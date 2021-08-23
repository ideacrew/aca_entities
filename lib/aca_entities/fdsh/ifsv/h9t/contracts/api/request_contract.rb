# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Api::Request}
            class RequestContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
              # @!method call(opts)
              # @param [hash] opts the parameters to validate using this contract
              # @option opts [AcaEntities::Fdsh::Types::RequestIDType] :RequestID required
              # @option opts [Array<AcaEntities::Fdsh::Ifsv::H9t::Api::IFSVApplicant>] :IFSVApplicants required
              # @return [Dry::Monads::Result]
              params do
                required(:RequestID).filled(
                  AcaEntities::Fdsh::Types::RequestIDType
                )

                required(:IFSVApplicants).array(
                  AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::IFSVApplicantContract
                    .params
                )
              end
            end
          end
        end
      end
    end
  end
end
