# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::BenchmarkPremium}
      class BenchmarkPremiumContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [BigDecimal] :monthly_slcsp_premium required
        # @option opts [BigDecimal] :monthly_lcsp_premium required
        # @return [Dry::Monads::Result]
        params do
          required(:monthly_slcsp_premium).filled(Types::Money)
          required(:monthly_lcsp_premium).filled(Types::Money)
        end
      end
    end
  end
end
