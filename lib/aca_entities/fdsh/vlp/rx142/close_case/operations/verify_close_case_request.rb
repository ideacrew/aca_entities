# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          module Operations
            # convert person entity to initial request
            class VerifyCloseCaseRequest
              include Dry::Monads[:result, :do, :try]

              def call(payload)
                validated_payload = yield validate_payload(payload)
                request_entity = yield close_case_request_entity(validated_payload)

                Success(request_entity)
              end

              private

              def validate_payload(payload)
                result = AcaEntities::Fdsh::Vlp::Rx142::CloseCase::Contracts::CloseCaseRequestContract.new.call(payload)
                result.success? ? Success(result) : Failure("Invalid VLP CloseCase request due to #{result.errors.to_h}")
              end

              def close_case_request_entity(payload)
                Success(AcaEntities::Fdsh::Vlp::Rx142::CloseCase::CloseCaseRequest.new(payload.to_h))
              end
            end
          end
        end
      end
    end
  end
end