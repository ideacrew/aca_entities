# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            module Fti
              # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::ErrorMessage}
              class ErrorMessageContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
                # @!method call(opts)
                # @param [hash] opts the parameters to validate using this contract
                # @option opts [AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::ResponseMetadata] :ResponseMetadata required
                # @option opts [AcaEntities::Types::String] :XPathContent required
                # @return [Dry::Monads::Result]
                params do
                  required(:ErrorMessageDetail).hash do
                    optional(:ResponseMetadata).maybe(
                      AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::Fti::ResponseMetadataContract
                        .params
                    )
                    optional(:XPathContent).maybe(:string)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
