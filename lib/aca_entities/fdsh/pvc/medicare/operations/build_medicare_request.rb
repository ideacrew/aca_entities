# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Medicare
        module Operations
          # build medicare request for pvc medicare service
          class BuildMedicareRequest
            include Dry::Monads[:result, :do, :try]

            def call(applicant, assistance_year)
              request_payload = construct_individual_request(applicant, assistance_year)
              Success(request_payload)
            end

            private

            def validate_payload(payload)
              result = AcaEntities::Fdsh::Pvc::Medicare::EesDshBatchRequestDataContract.new.call(payload)
              result.success? ? Success(result) : Failure("Invalid Non ESI request due to #{result.errors.to_h}")
            end

            def esi_mec_request_entity(payload)
              Success(AcaEntities::Fdsh::Pvc::Medicare::EesDshBatchRequestData.new(payload.to_h))
            end

            def construct_medicare_request(applications)
              request_groups = applications.collect do |application|
                construct_individual_request(application)
              end
              request = { IndividualRequests: request_groups.flatten }
              Success(request)
            end

            def can_skip_applicant?(applicant)
              applicant.identifying_information.encrypted_ssn.blank? || applicant.non_esi_evidence.blank?
            end

            def construct_individual_request(applicant, assistance_year)
              {
                Applicant: construct_request_applicant(applicant),
                InsurancePolicy: construct_insurance_policy(assistance_year)
              }
            end

            def construct_insurance_policy(year)
              {
                InsurancePolicyEffectiveDate: ::Date.new(year, 0o1, 0o1),
                InsurancePolicyExpirationDate: ::Date.new(year, 12, 31)
              }
            end

            def construct_request_applicant(applicant)
              {
                PersonSSNIdentification: decrypt_ssn(applicant.identifying_information&.encrypted_ssn),
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

            def decrypt_ssn(encrypted_ssn)
              AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn }).value!
            end
          end
        end
      end
    end
  end
end