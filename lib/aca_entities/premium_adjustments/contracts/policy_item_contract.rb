 frozen_string_literal: true

module AcaEntities
  module PremiumAdjustments
    module Contracts
      # Schema and validation rules for the {AcaEntities::PremiumCredits::Group} entity
      class PolicyItemContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [AcaEntities::PremiumCredits::Contracts::MemberContract] :members members of the group (required)
        # @option opts [String] :id unique key for this entity (optional)
        # @option opts [AcaEntities::PremiumCredits::Types::GroupKind] :kind the type of premium credit (required)
        # @option opts [AcaEntities::PremiumCredits::Contracts::ObjectReferenceContract]
        #  :authority_determination_reference the source of the premium credit (optional)
        # @option opts [AcaEntities::Types::Money] :premium_credit_monthly_cap the premium credit monthly cap (optional)
        # @option opts [AcaEntities::PremiumCredits::Contracts::ObjectReferenceContract]
        #  :sub_group_reference the sub group reference of the premium credit (optional)
        # @option opts [AcaEntities::Types::Money] :expected_contribution_percentage the expected contribution percentage (optional)
        # @option opts [Date] :start_on  (required)
        # @option opts [Date] :end_on  (optional)
        # @option opts [AcaEntities::Contracts::TimeStampContract] :timestamps (optional)
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          required(:agreement)
            optional(:agreement_id).value(:string)
            required(:insurance_product)
              optional(:id)
              required(:name)
            optional(:insurance_policy).Array(AcaEntities::InsurancePolicies::Contracts::InsurancePolicyContract.params)
              optional(:policy_number)
              required(:policy_item)
                required(:covered_member)
                required(:coverage_type)
                  optional(:id)
                required(:coverage_level)
                  optional(:id)
                required(:product_feature)
                  optional(:id)
                  required(:description)
                  required(:value)
                required(:policy_item_premium)
                  optional(:premium_schedule_seq_id)
                  required(:premium_amount)
                  required(:insurance_rate)
                    required(:begin_on).value(:date)
                    required(:end_on).value(:date)
                    required(:rate_amount).value(:float)
                    required(:factor_rates).array(AcaEntities::InsurancePolicies::Contracts::InsuranceRateFactorContract.params)
                    required(:risk_rates).array(AcaEntities::InsurancePolicies::Contracts::InsuranceRiskRateContract.params)
                  required(:policy_premium_adjustments).array(AcaEntities::InsurancePolicies::Contracts::PolicyPremiumAdustmentContract.params)
                    optional(:discount_premium_adjustment).
                    optional(:surcharge_premium_adjustment).
                    required(:adjustment_type)
                  optional(:policy_item_premium_billing)
                    optional(:invoice_item)
                  required(:premium_schedule)
                    required(:valid_from)
                    required(:valid_through)
                    required(:insured_from)
                    required(:insured_through)
                    required(:due_date)
                    required(:premium_amount)
                    required(:period_type)
                      optional(:id)
                      required(:description)











          required(:members).array(AcaEntities::PremiumCredits::Contracts::MemberContract.params)
          optional(:id).maybe(:string)
          required(:kind).filled(AcaEntities::PremiumCredits::Types::GroupKind)
          optional(:authority_determination_reference).hash(AcaEntities::PremiumCredits::Contracts::ObjectReferenceContract.params)
          optional(:premium_credit_monthly_cap).maybe(AcaEntities::Types::Money)
          optional(:sub_group_reference).hash(AcaEntities::PremiumCredits::Contracts::ObjectReferenceContract.params)
          optional(:expected_contribution_percentage).maybe(AcaEntities::Types::Money)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end