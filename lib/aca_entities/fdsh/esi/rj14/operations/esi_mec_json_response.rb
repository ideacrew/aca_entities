# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module Rj14
        module Operations
          # convert esi mec json response to application entity
          class EsiMecJsonResponse
            include Dry::Monads[:result, :do, :try]

            def call(params)
              validated_params = yield validate_params(params)
              validated_payload = yield validate_response_payload(validated_params[:response_payload])
              application_entity = yield build_application(validated_params[:application_hash])
              updated_application_hash = yield update_application(application_entity.to_h, validated_payload)
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
              schema_data = JSON.parse(File.read(Pathname.pwd.join("lib/aca_entities/fdsh/esi/rj14/schemas/ESIMEC-Response-schema.json")))
              result = begin
                JSON::Validator.fully_validate(schema_data, JSON.parse(payload.to_json))
              rescue JSON::Schema::ValidationError => e
                e.message
              end
              payload = JSON.parse(payload.to_json, symbolize_names: true)
              result.empty? ? Success(payload) : Failure(result.to_s)
            end

            def build_application(application_hash)
              result = AcaEntities::MagiMedicaid::Operations::InitializeApplication.new.call(application_hash)
              result.success? ? result : Failure(result.failure.errors.to_h)
            end

            def update_application(application_hash, esi_response)
              return Success(application_hash) if esi_response[:esiMECResponse][:responseMetadata].present?

              esi_response_hash = esi_response.to_h
              application_hash[:applicants].each do |applicant_hash|
                esi_applicant_response = find_response_for_applicant(applicant_hash, esi_response_hash)
                next unless esi_applicant_response

                check_esi_mec_eligibility(applicant_hash, esi_applicant_response)
              end

              Success(application_hash)
            end

            def check_esi_mec_eligibility(applicant_hash, esi_applicant_response)
              esi_response_hash = esi_response_params(esi_applicant_response)
              applicant = applicant_entity(applicant_hash)

              esi_eligibility_indicator = esi_response_hash[:esi_eligibility_indicator]
              esi_insured_indicator = esi_response_hash[:esi_insured_indicator]
              esi_inconsistency_indicator = esi_response_hash[:esi_inconsistency_indicator]

              applicant_is_esi_eligible = applicant.esi_eligible?
              applicant_is_esi_enrolled = applicant.esi_enrolled?
              esi_evidence = applicant.esi_evidence

              status = if !esi_inconsistency_indicator && (esi_eligibility_indicator || esi_insured_indicator) &&
                          (applicant_is_esi_eligible == false && applicant_is_esi_enrolled == false)
                         "outstanding"
                       else
                         "attested"
                       end

              updated_esi_evidence = update_esi_evidence(esi_applicant_response, esi_evidence.to_h, status)
              applicant_hash[:esi_evidence].merge!(updated_esi_evidence)
            end

            def esi_response_params(esi_applicant_response)
              {
                esi_eligibility_indicator: esi_applicant_response&.dig(:ApplicantMECInformation, :applicantEligibleESIIndicator),
                esi_insured_indicator: esi_applicant_response&.dig(:applicantMECInformation, :applicantInsuredIndicator),
                esi_inconsistency_indicator: esi_applicant_response&.dig(:applicantMECInformation, :inconsistencyIndicator)
              }
            end

            def update_esi_evidence(esi_applicant_response, esi_evidence_hash, status)
              request_result = request_result_hash(esi_applicant_response, status)
              esi_evidence_hash[:aasm_state] = status
              esi_evidence_hash[:request_results] = [request_result]
              esi_evidence_hash
            end

            def request_result_hash(esi_applicant_response, status)
              {
                result: status,
                source: "FDSH ESI MEC",
                code: esi_applicant_response&.dig(:responseMetadata, :responseCode),
                code_description: esi_applicant_response&.dig(:responseMetadata, :responseText),
                raw_payload: esi_applicant_response.to_json
              }
            end

            def applicant_entity(applicant_hash)
              AcaEntities::MagiMedicaid::Applicant.new(applicant_hash)
            end

            def find_response_for_applicant(applicant, esi_response)
              esi_response[:esiMECResponse][:applicantResponseArray].detect do |applicant_response|
                ssn = applicant_response[:personSocialSecurityNumber]
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
