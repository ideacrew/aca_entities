# frozen_string_literal: true

require 'json'
require 'json_schema'

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        module Operations
          # convert person entity to initial request
          class SsaVerificationJsonRequest
            include Dry::Monads[:result, :do, :try]

            def call(params)
              payload = yield construct_initial_request(params)
              validate_payload(payload)
            end

            private

            def construct_initial_request(payload)
              request = { ssaCompositeRequest: { ssaCompositeIndividualRequestArray: [construct_ssa_verification_request(payload)] } }
              Success(request)
            end

            def construct_ssa_verification_request(person)
              {
                personSocialSecurityNumber: decrypt_ssn(person.person_demographics.encrypted_ssn),
                personSurName: person.person_name.last_name&.gsub(/[^A-Za-z]/, ''),
                personBirthDate: construct_birth_date(person),
                requestCitizenshipVerificationIndicator: true,
                requestIncarcerationVerificationIndicator: true,
                requestTitleIIMonthlyIncomeVerificationIndicator: false,
                requestTitleIIAnnualIncomeVerificationIndicator: false,
                requestQuartersOfCoverageVerificationIndicator: false,
                personMiddleName: person.person_name.middle_name&.gsub(/[^A-Za-z]/, ''),
                personGivenName: person.person_name.first_name&.gsub(/[^A-Za-z]/, '')
                # "requestTitleIIMonthlyIncomeDate": "The month and year will be extracted for the Title II Monthly Income Service Request for which
                # the applicants Title II Monthly Income need to be verified with SSA.",
                # "requestTitleIIAnnualIncomeDate": "The year will be extracted for the Title II Annual Income Service Request for which
                # the applicants Title II Annual Income need to be verified with SSA.",
              }
            end

            def construct_birth_date(person)
              person&.person_demographics&.dob
            end

            def decrypt_ssn(encrypted_ssn)
              AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn }).value!
            end

            def validate_payload(payload)
              schema_data = JSON.parse(File.read("lib/aca_entities/fdsh/ssa/h3/schemas/SSAC-Request-Schema.json"))
              schema = JsonSchema.parse!(schema_data)
              # to do research what this line does
              schema.expand_references!
              result = schema.validate(JSON.parse(payload.to_json))
              result[0] ? Success(payload.to_json) : Failure("Invalid SSA request due to #{result[1].join(' AND ')}")
            end

          end
        end
      end
    end
  end
end