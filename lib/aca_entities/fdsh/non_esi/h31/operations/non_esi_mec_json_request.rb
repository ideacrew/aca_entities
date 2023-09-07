# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        module Operations
          # convert application to non esi mec json request
          class NonEsiMecJsonRequest
            include Dry::Monads[:result, :do, :try]

            def call(application)
              payload = yield construct_non_esi_mec_request(application)
              validate_payload(payload)
            end

            private

            def construct_non_esi_mec_request(application)
              request = { individualRequestArray: construct_individual_request(application) }

              Success({ verifyNonESIMECRequest: request })
            end

            def can_skip_applicant?(applicant)
              applicant.identifying_information.encrypted_ssn.blank? || applicant.non_esi_evidence.blank?
            end

            def construct_individual_request(application)
              application.applicants.collect do |applicant|
                next if can_skip_applicant?(applicant)

                org_codes = get_organization_codes(applicant)
                name = applicant.name
                applicant_hash = {
                  personSurName: parse_name(name&.last_name),
                  personGivenName: parse_name(name&.first_name),
                  personBirthDate: applicant.demographic.dob,
                  personSexCode: parse_gender(applicant.demographic),
                  personSocialSecurityNumber: decrypt_ssn(applicant.identifying_information&.encrypted_ssn),
                  usStateCode: applicant.home_address.state || applicant.addresses.last.state,
                  insurancePolicyEffectiveDate: ::Date.new(application.assistance_year, 0o1, 0o1),
                  insurancePolicyExpirationDate: ::Date.new(application.assistance_year, 12, 31)
                }
                applicant_hash[:personSuffixName] = parse_name(name.name_sfx) if name&.name_sfx.present?
                applicant_hash[:personMiddleName] = parse_name(name.middle_name) if name&.middle_name.present?
                applicant_hash[:organizationCodeArray] = org_codes if org_codes.present?
                applicant_hash
              end.compact
            end

            def parse_name(applicant_name)
              applicant_name&.gsub(/[^A-Za-z]/, '')
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

            def decrypt_ssn(encrypted_ssn)
              AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn }).value!
            end

            def validate_payload(payload)
              schema_data = JSON.parse(File.read(Pathname.pwd.join("lib/aca_entities/fdsh/non_esi/h31/schemas/VerifyNonESIMEC-Request-schema.json")))
              result = begin
                JSON::Validator.fully_validate(schema_data, JSON.parse(payload.to_json))
              rescue JSON::Schema::ValidationError => e
                e.message
              end
              result.empty? ? Success(payload.to_json) : Failure(result.to_s)
            end
          end
        end
      end
    end
  end
end