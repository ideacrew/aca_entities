# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      module BenchmarkProducts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::BenchmarkProducts::BenchmarkProduct}
        class BenchmarkProductContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Date] :effective_date required
          # @option opts [AcaEntities::Contracts::Locations::AddressContract] :primary_rating_address required
          # @option opts [String] :exchange_provided_code required
          # @option opts [AcaEntities::Types::Money] :household_group_ehb_premium required
          # @option opts [AcaEntities::MagiMedicaid::Contracts::BenchmarkProducts::HouseholdContract] :households required
          # @return [Dry::Monads::Result]
          params do
            required(:effective_date).filled(:date)
            required(:primary_rating_address).filled(AcaEntities::Contracts::Locations::AddressContract.params)
            required(:exchange_provided_code).filled(:string)
            required(:household_group_ehb_premium).filled(::AcaEntities::Types::Money)
            required(:households).array(HouseholdContract.params)
          end
        end
      end
    end
  end
end
