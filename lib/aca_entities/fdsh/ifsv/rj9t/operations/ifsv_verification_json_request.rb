# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module Rj9t
        module Operations
          # convert application to ifsv json request
          class IfsvVerificationJsonRequest
            include Dry::Monads[:result, :do, :try]

            def call(application)
              payload = yield construct_ifsv_request(application)
              validate_payload(payload)
            end

            private

            def construct_ifsv_request(application)
              request = {
                requestID: application.hbx_id,
                applicantArray: construct_ifsv_applicant_request(application)
              }

              Success({ ifsvRequest: request })
            end

            def construct_ifsv_applicant_request(application)
              application.applicants.collect do |applicant|
                next if can_skip_applicant?(applicant)
                name = applicant.name

                {
                  personGivenName: parse_name(name&.first_name),
                  personMiddleName: parse_name(name&.middle_name),
                  personSurName: parse_name(name&.last_name),
                  personNameSuffix: parse_name(name&.name_sfx),
                  personSocialSecurityNumber: decrypt_ssn(applicant),
                  taxFilerCategoryCode: fetch_tax_filing_code(application, applicant)
                }.compact
              end.compact
            end

            def can_skip_applicant?(applicant)
              applicant.identifying_information.encrypted_ssn.blank? || applicant.income_evidence.blank?
            end

            def parse_name(applicant_name)
              applicant_name&.gsub(/[^A-Za-z]/, '')
            end

            def fetch_tax_filing_code(application, applicant)
              relationship_kind = fetch_relationship_kind(application, applicant)
              if applicant.is_primary_applicant
                "PRIMARY"
              elsif relationship_kind == "spouse"
                "SPOUSE"
              else
                "DEPENDENT"
              end
            end

            def fetch_relationship_kind(application, applicant)
              relationship = application.relationships.detect { |rel| rel.applicant_reference.person_hbx_id == applicant.person_hbx_id }
              relationship&.kind
            end

            def decrypt_ssn(applicant)
              encrypted_ssn = applicant&.identifying_information&.encrypted_ssn
              AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn }).value!
            end

            def validate_payload(payload)
              schema_data = JSON.parse(File.read(Pathname.pwd.join("lib/aca_entities/fdsh/ifsv/rj9t/schemas/IFSV-Request-schema.json")))
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