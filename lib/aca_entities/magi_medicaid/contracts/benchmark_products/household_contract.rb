# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      module BenchmarkProducts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::BenchmarkProducts::Household}
        class HouseholdContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :household_hbx_id required
          # @option opts [String] :type_of_household required
          # @option opts [AcaEntities::Types::Money] :household_ehb_premium required
          # @option opts [AcaEntities::Types::Money] :household_health_ehb_premium required
          # @option opts [AcaEntities::Contracts::Products::ProductReferenceContract] :health_product_reference required
          # @option opts [AcaEntities::Types::Money] :household_dental_ehb_premium optional
          # @option opts [AcaEntities::Contracts::Products::ProductReferenceContract] :dental_product_reference optional
          # @option opts [AcaEntities::MagiMedicaid::Contracts::BenchmarkProducts::MemberContract] :members required
          # @return [Dry::Monads::Result]
          params do
            required(:household_hbx_id).filled(:string)
            required(:type_of_household).filled(::AcaEntities::MagiMedicaid::Types::BenchmarkProductsHouseholdType)
            required(:household_ehb_premium).filled(::AcaEntities::Types::Money)
            required(:household_health_ehb_premium).filled(::AcaEntities::Types::Money)
            required(:health_product_reference).filled(AcaEntities::Contracts::Products::ProductReferenceContract.params)

            optional(:household_dental_ehb_premium).maybe(::AcaEntities::Types::Money)
            optional(:dental_product_reference).maybe(AcaEntities::Contracts::Products::ProductReferenceContract.params)

            required(:members).array(MemberContract.params)
          end
        end
      end
    end
  end
end
