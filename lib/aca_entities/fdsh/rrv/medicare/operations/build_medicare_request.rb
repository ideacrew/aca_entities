# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        module Operations
          # build medicare request for rrv medicare service
          class BuildMedicareRequest
            include Dry::Monads[:result, :do, :try]

            def call(application)
              payload = yield construct_medicare_request(application)
              validated_payload = yield validate_payload(payload)
              request_entity = yield esi_mec_request_entity(validated_payload)

              Success(request_entity)
            end

            private

            def validate_payload(payload)
              result = AcaEntities::Fdsh::Rrv::Medicare::EesDshBatchRequestDataContract.new.call(payload)
              result.success? ? Success(result) : Failure("Invalid Non ESI request due to #{result.errors.to_h}")
            end

            def esi_mec_request_entity(payload)
              Success(AcaEntities::Fdsh::Rrv::Medicare::EesDshBatchRequestData.new(payload.to_h))
            end

            def construct_medicare_request(application)
              request = { IndividualRequests: construct_individual_request(application) }

              Success(request)
            end

            def construct_individual_request(application)
              application.applicants.collect do |applicant|
                next unless applicant.identifying_information.ssn.present?
                individual_request = {
                  Applicant: construct_request_applicant(applicant),
                  InsurancePolicy: construct_insurance_policy(application.assistance_year)
                }
                individual_request
              end
            end

            def construct_insurance_policy(year)
              {
                InsurancePolicyEffectiveDate: ::Date.new(year, 0o1, 0o1),
                InsurancePolicyExpirationDate: ::Date.new(year, 12, 31)
              }
            end

            def construct_request_applicant(applicant)
              {
                PersonSSNIdentification: applicant.identifying_information&.ssn,
                PersonName: construct_person_name(applicant.name),
                PersonBirthDate: applicant.demographic.dob,
                PersonSexCode: parse_gender(applicant.demographic)
              }
            end

            def parse_gender(demographic)
              case demographic.gender.downcase
              when 'male'
                'M'
              when 'female'
                'F'
              else
                'U'
              end
            end

            def construct_person_name(applicant_name)
              {
                PersonGivenName: applicant_name&.first_name,
                PersonMiddleName: applicant_name&.middle_name,
                PersonSurName: applicant_name&.last_name,
                PersonNameSuffixText: applicant_name&.name_sfx
              }
            end
          end
        end
      end
    end
  end
end