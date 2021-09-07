# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            module Fti
              # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::Response}
              class ResponseContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
                # @!method call(opts)
                # @param [hash] opts the parameters to validate using this contract
                # @option opts [AcaEntities::Fdsh::Ifsv::H9t::Fti::IRSResponse] :IRSResponse required
                # @option opts [AcaEntities::Fdsh::Ifsv::H9t::Fti::ErrorMessage] :ErrorMessage optional
                # @return [Dry::Monads::Result]
                params do
                  optional(:IRSResponse).value(
                    AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::Fti::IRSResponseContract
                      .params
                  )
                  optional(:ErrorMessage).value(
                    AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::Fti::ErrorMessageContract
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
