# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::MemberDetermination}
      class MemberDeterminationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [::AcaEntities::MagiMedicaid::Types::MemberDeterminationKind] :kind optional
        # @option opts [Boolean] :is_eligible optional
        # @option opts [Array] :determination_reasons optional
        # @return [Dry::Monads::Result]
        params do
          optional(:kind).maybe(::AcaEntities::MagiMedicaid::Types::MemberDeterminationKind)
          optional(:is_eligible).maybe(:bool)
          optional(:determination_reasons).array(:symbol)
          optional(:eligibility_overrides).array(AcaEntities::MagiMedicaid::Contracts::EligibilityOverrideContract.params)
        end
      end
    end
  end
end
