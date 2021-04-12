# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::FosterCare}
      class FosterCareContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_former_foster_care optional
        # @option opts [Integer] :age_left_foster_care optional
        # @option opts [String] :foster_care_us_state optional
        # @option opts [Boolean] :had_medicaid_during_foster_care optional
        # @return [Dry::Monads::Result]
        params do
          optional(:is_former_foster_care).maybe(:bool)
          optional(:age_left_foster_care).maybe(:integer)
          optional(:foster_care_us_state).maybe(Types::UsStateAbbreviationKind)
          optional(:had_medicaid_during_foster_care).maybe(:bool)
        end
      end
    end
  end
end
