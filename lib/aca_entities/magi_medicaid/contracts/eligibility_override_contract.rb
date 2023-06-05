# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::EligibilityOverride'}
      class EligibilityOverrideContract < Dry::Validation::Contract

        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [::AcaEntities::MagiMedicaid::Types::EligibilityOverrideRule] :override_rule optional
        # @option opts [Boolean] :override_applied optional
        # @return [Dry::Monads::Result]
        params do
          optional(:override_rule).maybe(::AcaEntities::MagiMedicaid::Types::EligibilityOverrideRule)
          optional(:override_applied).maybe(:bool)
        end
      end
    end
  end
end