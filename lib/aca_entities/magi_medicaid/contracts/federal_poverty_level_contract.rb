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
        # @option opts [BigDecimal] :annual_poverty_guideline required
        # @option opts [BigDecimal] :add_person_annual_amount required
        # @option opts [BigDecimal] :monthly_poverty_guideline required
        # @option opts [BigDecimal] :add_person_monthly_amount required
        # @option opts [Date] :effective_start_on required
        # @option opts [Date] :effective_end_on required
        # @return [Dry::Monads::Result]
        params do
          required(:state_code).filled(
            AcaEntities::Types::UsStateAbbreviationKind
          )
          required(:household_size).filled(:integer)
          required(:annual_poverty_guideline).filled(AcaEntities::Types::Money)
          required(:add_person_annual_amount).filled(AcaEntities::Types::Money)
          required(:monthly_poverty_guideline).filled(AcaEntities::Types::Money)
          required(:add_person_monthly_amount).filled(AcaEntities::Types::Money)
          required(:effective_start_on).filled(:date)
          required(:effective_end_on).filled(:date)
        end
      end
    end
  end
end
