# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::Household}
      class TaxHouseholdGroupContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :aasm_state required
        # @option opts [Integer] :assistance_year optional
        # @option opts [Date] :start_on required
        # @option opts [Date] :end_on optional
        # @option opts [String] :source optional
        # @option opts [Hash] :application_reference optional
        # @option opts [Hash] :tax_households optional
        # @return [Dry::Monads::Result]
        params do
          required(:aasm_state).value(:string)
          required(:assistance_year).filled(:integer)
          required(:start_on).value(:date)
          optional(:end_on).maybe(:date)
          optional(:source).maybe(::AcaEntities::Types::EligibilityDeterminationSourceKinds)
          optional(:application_reference).maybe(AcaEntities::MagiMedicaid::Contracts::ApplicationReferenceContract.params)
          optional(:tax_households).array(AcaEntities::Contracts::Households::TaxHouseholdContract.params)
          optional(:household_group_benchmark_ehb_premium).maybe(Types::Money)
        end
      end
    end
  end
end
