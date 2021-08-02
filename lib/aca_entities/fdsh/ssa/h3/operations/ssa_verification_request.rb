# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        module Operations
          # convert person entity to initial request
          class SsaVerificationRequest
            include Dry::Monads[:result, :do, :try]

            def call(params)
              payload = yield construct_initial_request(params)
              validated_payload = yield validate_payload(payload)
              request_entity = yield initial_verification_request_entity(validated_payload)

              Success(request_entity)
            end

            private

            def validate_payload(payload)
              result = AcaEntities::Fdsh::Ssa::H3::SSACompositeRequestContract.new.call(payload)
              result.success? ? Success(result) : Failure("Invalid SSA request due to #{result.errors.to_h}")
            end

            def initial_verification_request_entity(payload)
              Success(AcaEntities::Fdsh::Ssa::H3::SSACompositeRequest.new(payload.to_h))
            end

            def construct_initial_request(payload)
              request = { SSACompositeIndividualRequests: [construct_ssa_verification_request(payload)] }
              Success(request)
            end

            def construct_ssa_verification_request(person)
              {
                Person: construct_person(person),
                RequestCitizenshipVerificationIndicator: true,
                RequestIncarcerationVerificationIndicator: person.person_demographics.is_incarcerated,
                RequestTitleIIMonthlyIncomeVerificationIndicator: false,
                RequestTitleIIAnnualIncomeVerificationIndicator: false,
                RequestQuartersOfCoverageVerificationIndicator: false
              }
            end

            def construct_person(person)
              {
                PersonSSNIdentification: person.person_demographics.ssn,
                PersonName: construct_person_name(person),
                PersonBirthDate: construct_birth_date(person)
              }
            end

            def construct_person_name(person)
              {
                PersonGivenName: person.person_name.first_name,
                PersonMiddleName: person.person_name.middle_name,
                PersonSurName: person.person_name.last_name
              }
            end

            def construct_birth_date(person)
              {
                Date: person.person_demographics.dob
              }
            end
          end
        end
      end
    end
  end
end