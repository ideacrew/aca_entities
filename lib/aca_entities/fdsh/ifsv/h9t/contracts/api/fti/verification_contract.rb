# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            module Fti
              # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::Verification}
              class VerificationContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
                # @!method call(opts)
                # @param [hash] opts the parameters to validate using this contract
                # @option opts [AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::TaxReturn] :TaxReturn required
                # @option opts [Array<AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::ResponseMetadata>] :ResponseMetadata required
                # @return [Dry::Monads::Result]
                params do
                  required(:TaxReturn).value(
                    AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::Fti::TaxReturnContract
                      .params
                  )

                  required(:ResponseMetadata).array(
                    AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::Fti::ResponseMetadataContract
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
end
