# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::CreateFederalPoveryLevel}
      class CreateFederalPovertyLevelContract < AcaEntities::MagiMedicaid::Contracts::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [AcaEntities::Types::UsStateAbbreviationKind] :state_code required
        # @option opts [Integer] :medicaid_year required
        # @option opts [Integer] :household_size required
        # @option opts [BigDecimal] :annual_poverty_guideline required
        # @option opts [BigDecimal] :annual_per_person_amount required
        # @return [Dry::Monads::Result]
        params do
          required(:state_code).filled(
            AcaEntities::Types::UsStateAbbreviationKind
          )
          required(:medicaid_year).filled(:integer)
          required(:household_size).filled(:integer)
          required(:annual_poverty_guideline).filled(AcaEntities::Types::Money)
          required(:annual_per_person_amount).filled(AcaEntities::Types::Money)
        end
      end
    end
  end
end
