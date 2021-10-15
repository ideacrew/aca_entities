# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Operations
          # convert person entity to initial request
          class BuildEsiMecRequest
            include Dry::Monads[:result, :do, :try]

            def call(application)
              payload = yield construct_esi_mec_request(application)
              validated_payload = yield validate_payload(payload)
              request_entity = yield esi_mec_request_entity(validated_payload)

              Success(request_entity)
            end

            private

            def validate_payload(payload)
              result = AcaEntities::Fdsh::Esi::H14::ESIMECRequestContract.new.call(payload)
              result.success? ? Success(result) : Failure("Invalid ESI request due to #{result.errors.to_h}")
            end

            def esi_mec_request_entity(payload)
              Success(AcaEntities::Fdsh::Esi::H14::ESIMECRequest.new(payload.to_h))
            end

            def construct_esi_mec_request(application)
              request = { ApplicantRequests: construct_applicant_request(application) }

              Success(request)
            end

            def construct_applicant_request(application)
              application.applicants.collect do |applicant|
                next unless applicant.identifying_information.encrypted_ssn.present?
                {
                  RequestPerson: construct_request_person(applicant),
                  InsuranceApplicantRequest: construct_insurance_request(application.assistance_year),
                  PersonLocationState: applicant.home_address.state
                }
              end
            end

            def construct_insurance_request(year)
              {
                InsuranceApplicantRequestedCoverage: {
                  StartDate: ::Date.new(year, 0o1, 0o1),
                  EndDate: ::Date.new(year, 12, 31)
                }
              }
            end

            def construct_request_person(applicant)
              {
                PersonBirthDate: applicant.demographic.dob,
                PersonName: construct_person_name(applicant.name),
                PersonSexCode: parse_gender(applicant.demographic),
                PersonSSNIdentification: { IdentificationID: decrypt_ssn(applicant.identifying_information&.encrypted_ssn) }
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