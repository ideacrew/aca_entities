# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        module Operations
          # convert person entity to initial request
          class BuildNonEsiMecRequest
            include Dry::Monads[:result, :do, :try]

            def call(application)
              payload = yield construct_non_esi_mec_request(application)
              validated_payload = yield validate_payload(payload)
              request_entity = yield esi_mec_request_entity(validated_payload)

              Success(request_entity)
            end

            private

            def validate_payload(payload)
              result = AcaEntities::Fdsh::NonEsi::H31::VerifyNonESIMECRequestContract.new.call(payload)
              result.success? ? Success(result) : Failure("Invalid Non ESI request due to #{result.errors.to_h}")
            end

            def esi_mec_request_entity(payload)
              Success(AcaEntities::Fdsh::NonEsi::H31::VerifyNonESIMECRequest.new(payload.to_h))
            end

            def construct_non_esi_mec_request(application)
              request = { IndividualRequests: construct_individual_request(application) }

              Success(request)
            end

            def construct_individual_request(application)
              application.applicants.collect do |applicant|
                next unless applicant.identifying_information.encrypted_ssn.present?
                org_codes = get_organization_codes(applicant)
                individual_request = {
                  Applicant: construct_request_applicant(applicant),
                  LocationStateUSPostalServiceCode: applicant.home_address.state,
                  InsurancePolicy: construct_insurance_policy(application.assistance_year)
                }
                individual_request.merge!({ Organization: { OrganizationCodes: org_codes } }) if org_codes.present?
                individual_request
              end
            end

            def get_organization_codes(applicant)
              applicant.benefits.collect do |benefit|
                fetch_non_esi_org_code(benefit)
              end.compact.uniq
            end

            def fetch_non_esi_org_code(benefit)
              {
                'tricare' => 'TRIC',
                'veterans_administration_health_benefits' => 'VHPC',
                'peace_corps_health_benefits' => 'PECO',
                'medicare' => 'MEDI'
              }[benefit.kind]
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