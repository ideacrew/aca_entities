# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Groups
      # Schema and validation rules for {AcaEntities::Groups::IrsGroup}
      class IrsGroupContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id optional
        # @option opts [Date] :start_on optional
        # @option opts [Date] :end_on optional
        # @option opts [Boolean] :is_active optional
        # @return [Dry::Monads::Result]
        params do
          optional(:hbx_id).value(:str?)
          optional(:start_on).value(:date?)
          optional(:end_on).value(:date?)
          optional(:is_active).maybe(:bool)
        end
      end
    end
  end
end
