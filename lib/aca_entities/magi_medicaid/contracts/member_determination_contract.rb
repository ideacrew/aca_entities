# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::MemberDetermination}
      class MemberDeterminationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [::AcaEntities::MagiMedicaid::Types::MemberDeterminationKind] :kind
        # @option opts [Boolean] :criteria_met
        # @option opts [Array] :determination_reasons
        # @option opts [Array] :eligibility_overrides
        # @return [Dry::Monads::Result]
        params do
          required(:kind).maybe(::AcaEntities::MagiMedicaid::Types::MemberDeterminationKind)
          required(:criteria_met).maybe(:bool)
          required(:determination_reasons).array(:string)
          required(:eligibility_overrides).array(AcaEntities::MagiMedicaid::Contracts::EligibilityOverrideContract.params)
        end
      end
    end
  end
end
