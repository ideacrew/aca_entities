# frozen_string_literal: true

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
              # validated_payload = yield validate_payload(payload)
              request_entity = yield initial_verification_request_payload(payload.to_json)

              Success(request_entity)
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
              person.person_demographics.dob
            end

            def decrypt_ssn(encrypted_ssn)
              AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn }).value!
            end

            def validate_payload(payload)
              # Todo validate with Json rather than contracts.
              # result = AcaEntities::Fdsh::Ssa::H3::SSACompositeRequestContract.new.call(payload.to_json)
              # result.success? ? Success(result) : Failure("Invalid SSA request due to #{result.errors.to_h}")
            end

            def initial_verification_request_payload(json_payload)
              # Todo create a new entity based on the new JSON or Just send the JSON.
              Success(json_payload)
            end

          end
        end
      end
    end
  end
end