# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            module Fti
              # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::ResponseMetadata}
              class ResponseMetadataContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
                # @!method call(opts)
                # @param [hash] opts the parameters to validate using this contract
                # @option opts [AcaEntities::Types::String] :ResponseCode required
                # @option opts [AcaEntities::Types::String] :ResponseDescriptionText required
                # @option opts [AcaEntities::Types::String] :TDSResponseDescriptionText required
                # @return [Dry::Monads::Result]
                params do
                  optional(:ResponseCode).filled(AcaEntities::Types::String)
                  optional(:ResponseDescriptionText).filled(
                    AcaEntities::Types::String
                  )
                  optional(:TDSResponseDescriptionText).filled(
                    AcaEntities::Types::String
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
