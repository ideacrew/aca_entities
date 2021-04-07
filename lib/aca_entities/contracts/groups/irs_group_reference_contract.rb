# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Groups
      # Schema and validation rules for {AcaEntities::Groups::IrsGroupReference}
      class IrsGroupReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id optional
        # @return [Dry::Monads::Result]
        params do
          optional(:hbx_id).maybe(:string)
        end
      end
    end
  end
end
