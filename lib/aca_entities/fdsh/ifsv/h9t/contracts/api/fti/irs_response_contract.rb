# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            module Fti
              # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::IRSResponse}
              class IRSResponseContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
                # @!method call(opts)
                # @param [hash] opts the parameters to validate using this contract
                # @option opts [AcaEntities::Fdsh::Ifsv::H9t::Types::RequestIDType] :RequestID required
                # @option opts [AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::Household] :Household required
                # @return [Dry::Monads::Result]
                params do
                  required(:RequestID).filled(
                    AcaEntities::Fdsh::Types::RequestIDType
                  )

                  required(:Household).value(
                    AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::Fti::HouseholdContract
                      .params
                  )
                end
                rule(:RequestID).validate(:fdsh_request_id_format)
              end
            end
          end
        end
      end
    end
  end
end
