# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        module Operations
          # validate non esi response and update application
          class NonEsiMecJsonResponse
            include Dry::Monads[:result, :do, :try]

            BENEFIT_TYPES = [{ MEDI: 'medicare' }, { TRIC: 'tricare' }, { PECO: 'peace_corps_health_benefits' },
                             { VHPC: 'veterans_administration_health_benefits' }].freeze

            def call(params)
              validated_params = yield validate_params(params)
              validated_payload = yield validate_response_payload(validated_params[:response_payload])
              updated_application_hash = yield update_application(validated_params[:application_hash], validated_payload)
              updated_application = yield build_application(updated_application_hash)

              Success(updated_application)
            end

            private

            def validate_params(params)
              return Failure("No application payload found") if params[:application_hash].blank?
              return Failure("No response payload found") if params[:response_payload].blank?
              Success(params)
            end

            def validate_response_payload(payload)
              schema_data = JSON.parse(File.read(Pathname.pwd.join("lib/aca_entities/fdsh/non_esi/h31/schemas/VerifyNonESIMEC-Response-schema.json")))

              result = begin
                JSON::Validator.fully_validate(schema_data, JSON.parse(payload.to_json))
              rescue JSON::Schema::ValidationError => e
                e.message
              end
              payload = JSON.parse(payload.to_json, symbolize_names: true)
              result.empty? ? Success(payload) : Failure(result.to_s)
            end

            def update_application(application_hash, non_esi_response)
              if non_esi_response[:verifyNonESIMECResponse][:responseMetadata].present?
                return failure_response_metadata(application_hash,
                                                 non_esi_response)
              end

              non_esi_response_hash = non_esi_response.to_h
              application_hash[:applicants].each do |applicant_hash|
                non_esi_applicant_response = find_response_for_applicant(applicant_hash, non_esi_response_hash)
                next unless non_esi_applicant_response

                check_non_esi_mec_eligibility(applicant_hash, non_esi_applicant_response)
              end

              Success(application_hash)
            end

            def build_application(application_hash)
              result = AcaEntities::MagiMedicaid::Operations::InitializeApplication.new.call(application_hash)
              result.success? ? result : Failure(result.failure.errors.to_h)
            end

            def check_non_esi_mec_eligibility(applicant_hash, applicant_response)
              applicant = applicant_entity(applicant_hash)
              non_esi_evidence = applicant.non_esi_evidence

              eligibility_results = BENEFIT_TYPES.collect do |benefit_type|
                benefit_type.collect do |key, value|
                  org_response = organization_response(applicant_response, key.to_s)
                  eligibility = org_response&.dig(:mecCoverage, :mecVerificationCode) == 'Y'
                  benefits = applicant.health_benefits_for(value)
                  status = benefits == false && eligibility ? 'outstanding' : 'attested'
                  request_result_hash(org_response, status, "FDSH #{key}")
                end
              end.flatten!
              ineligible_status = eligibility_results.any? {|eligibility| eligibility[:result] == 'ineligible'}
              status = ineligible_status ? 'outstanding' : 'attested'
              updated_non_esi_evidence = update_non_esi_evidence(applicant_response, non_esi_evidence.to_h, eligibility_results, status)
              applicant_hash[:non_esi_evidence].merge!(updated_non_esi_evidence)
            end

            def update_non_esi_evidence(_applicant_response, esi_evidence_hash, request_results, status)
              esi_evidence_hash[:aasm_state] = status
              esi_evidence_hash[:request_results] = request_results
              esi_evidence_hash
            end

            def organization_response(applicant_response, code)
              applicant_response[:otherCoverageArray].detect {|coverage| coverage[:organizationCode] == code}
            end

            def failure_response_metadata(application_hash, non_esi_response)
              application_hash[:applicants].each do |applicant_hash|
                non_esi_evidence = applicant_hash[:non_esi_evidence]
                request_result = request_result_hash(non_esi_response, 'ineligible', "FDSH NON_ESI")
                non_esi_evidence[:request_results] = [request_result]
                applicant_hash[:non_esi_evidence].merge!(non_esi_evidence)
              end

              Success(application_hash)
            end

            def request_result_hash(response, status, source)
              {
                result: (status == 'outstanding') ? "ineligible" : 'eligible',
                source: source,
                code: response&.dig(:responseMetadata, :responseCode),
                code_description: response&.dig(:responseMetadata, :responseText),
                raw_payload: response.to_json
              }
            end

            def applicant_entity(applicant_hash)
              AcaEntities::MagiMedicaid::Applicant.new(applicant_hash)
            end

            def find_response_for_applicant(applicant, non_esi_response)
              non_esi_response[:verifyNonESIMECResponse][:individualResponseArray].detect do |individual_response|
                ssn = individual_response[:personSocialSecurityNumber]
                encrypted_ssn = AcaEntities::Operations::Encryption::Encrypt.new.call({ value: ssn }).value!
                applicant[:identifying_information][:encrypted_ssn] == encrypted_ssn
              end
            end
          end
        end
      end
    end
  end
end