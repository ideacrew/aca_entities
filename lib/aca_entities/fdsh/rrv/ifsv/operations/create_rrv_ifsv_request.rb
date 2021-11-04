# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        module Ifsv
          module Operations
            # convert Application entity to request
            class CreateRrvIfsvRequest
              include Dry::Monads[:result, :do, :try]

              def call(request_groups)
                payload = yield construct_ifsv_request(request_groups)
                validated_payload = yield validate_payload(payload)
                request_entity = yield ifsv_request_entity(validated_payload)

                Success(request_entity)
              end

              private

              def validate_payload(payload)
                result = AcaEntities::Fdsh::Rrv::Ifsv::VerifyHouseholdIncomeBulkRequestContract.new.call(payload)
                result.success? ? Success(result) : Failure("Invalid IFSV due to #{result.errors.to_h}")
              end

              def ifsv_request_entity(payload)
                Success(AcaEntities::Fdsh::Rrv::Ifsv::VerifyHouseholdIncomeBulkRequest.new(payload.to_h))
              end

              def construct_ifsv_request(request_groups)
                request = {
                  IFSVApplicantRequestGrps: request_groups
                }

                Success(request)
              end
            end
          end
        end
      end
    end
  end
end