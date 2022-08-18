# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::TaxHousehold}
      class TaxHouseholdContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [Hash] :allocated_aptc optional
        # @option opts [Boolean] :is_eligibility_determined optional
        # @option opts [Date] :start_date optional
        # @option opts [Date] :end_date optional
        # @option opts [Array] :tax_household_members optional
        # @option opts [Array] :eligibility_determinations optional
        # @option opts [AcaEntities::Types::Money] :yearly_expected_contribution optional
        # @return [Dry::Monads::Result]
        params do
          optional(:hbx_id).maybe(:string)
          optional(:allocated_aptc).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:is_eligibility_determined).maybe(:bool)
          optional(:start_date).value(:date)
          optional(:end_date).value(:date)
          required(:tax_household_members).array(AcaEntities::Contracts::Households::TaxHouseholdMemberContract.params)
          optional(:eligibility_determinations).array(AcaEntities::Contracts::Determinations::EligibilityDeterminationContract.params)

          # Yearly Expected Contribution
          optional(:yearly_expected_contribution).maybe(::AcaEntities::Types::Money)

          optional(:determination_reference).maybe(AcaEntities::Contracts::Determinations::EligibilityDeterminationReferenceContract.params)
          optional(:max_aptc).maybe(AcaEntities::Contracts::CurrencyContract.params)
          optional(:monthly_expected_contribution).maybe(::AcaEntities::Types::Money)
          optional(:aptc_accumulator).maybe(AcaEntities::AptcCsrEligibilitiesEnrollments::Contracts::AptcAccumulatorContract.params)
          optional(:contribution_accumulators).maybe(AcaEntities::AptcCsrEligibilitiesEnrollments::Contracts::ContributionAccumulatorContract.params)
        end
      end
    end
  end
end
