# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::TaxHouseholdMembe}
      class TaxHouseholdMemberContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :family_member required
        # @option opts [Hash] :product_eligibility_determination optional
        # @option opts [Boolean] :is_subscriber optional
        # @option opts [Date] :reason optional
        # @return [Dry::Monads::Result]
        params do
          optional(:family_member_reference).hash(AcaEntities::Contracts::Families::FamilyMemberReferenceContract.params)
          optional(:product_eligibility_determination).hash(AcaEntities::Contracts::Determinations::ProductEligibilityDeterminationContract.params)
          optional(:is_subscriber).value(:bool?)
          optional(:tax_filer_status).maybe(AcaEntities::Types::TaxFilerKind)
          optional(:relation_with_primary).maybe(:string)
          optional(:slcsp_benchmark_premium).maybe(AcaEntities::Contracts::CurrencyContract.params)
          optional(:reason).maybe(:string)
        end
      end
    end
  end
end
