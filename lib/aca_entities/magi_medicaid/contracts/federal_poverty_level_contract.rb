# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::FederalPoveryLevel}
      class FederalPovertyLevelContract < AcaEntities::MagiMedicaid::Contracts::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :state_code required
        # @option opts [Integer] :household_size required
        # @option opts [Integer] :medicaid_year required
        # @option opts [BigDecimal] :annual_poverty_guideline required
        # @option opts [BigDecimal] :annual_per_person_amount required
        # @option opts [BigDecimal] :monthly_poverty_guideline required
        # @option opts [BigDecimal] :monthly_per_person_amount required
        # @option opts [Date] :aptc_effective_start_on required
        # @option opts [Date] :aptc_effective_end_on required
        # @return [Dry::Monads::Result]
        params do
          required(:state_code).filled(
            AcaEntities::Types::UsStateAbbreviationKind
          )
          required(:household_size).filled(:integer)
          required(:medicaid_year).filled(:integer)
          required(:annual_poverty_guideline).filled(AcaEntities::Types::Money)
          required(:annual_per_person_amount).filled(AcaEntities::Types::Money)
          required(:monthly_poverty_guideline).filled(AcaEntities::Types::Money)
          required(:monthly_per_person_amount).filled(AcaEntities::Types::Money)
          required(:aptc_effective_start_on).filled(:date)
          required(:aptc_effective_end_on).filled(:date)
        end
      end
    end
  end
end
