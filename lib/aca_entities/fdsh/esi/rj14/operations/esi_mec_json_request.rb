# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module Rj14
        module Operations
          # convert application to esi mec json request
          class EsiMecJsonRequest
            include Dry::Monads[:result, :do, :try]

            def call(application)
              payload = yield construct_esi_mec_request(application)
              validate_payload(payload)
            end

            private

            def construct_esi_mec_request(application)
              request = { applicantRequestArray: construct_individual_request(application) }

              Success({ esiMECRequest: request })
            end

            def can_skip_applicant?(applicant)
              applicant.identifying_information.encrypted_ssn.blank? || applicant.esi_evidence.blank?
            end

            def construct_individual_request(application)
              application.applicants.collect do |applicant|
                next if can_skip_applicant?(applicant)

                name = applicant.name
                applicant_hash = {
                  personSurName: parse_name(name&.last_name),
                  personGivenName: parse_name(name&.first_name),
                  personBirthDate: applicant.demographic.dob,
                  personSexCode: parse_gender(applicant.demographic),
                  personSocialSecurityNumber: decrypt_ssn(applicant.identifying_information&.encrypted_ssn),
                  usStateCode: applicant.home_address.state || applicant.addresses.last.state,
                  requestedCoveragePeriod: construct_insurance_request(application.assistance_year)
                }
                applicant_hash[:personSuffixName] = parse_name(name.name_sfx) if name&.name_sfx.present?
                applicant_hash[:personMiddleName] = parse_name(name.middle_name) if name&.middle_name.present?
                applicant_hash
              end.compact
            end

            def parse_name(applicant_name)
              applicant_name&.gsub(/[^A-Za-z]/, '')
            end

            def construct_insurance_request(year)
              {
                startDate: ::Date.new(year, 0o1, 0o1),
                endDate: ::Date.new(year, 12, 31)
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

            def decrypt_ssn(encrypted_ssn)
              AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn }).value!
            end

            def validate_payload(payload)
              schema_data = JSON.parse(File.read(Pathname.pwd.join("lib/aca_entities/fdsh/esi/rj14/schemas/ESIMEC-Request-schema.json")))
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