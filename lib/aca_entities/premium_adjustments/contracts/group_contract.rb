# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    module Contracts
      # Schema and validation rules for the {AcaEntities::PremiumCredits::Group} entity
      class GroupContract < Dry::Validation::Contract
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

        # GroupPremiumCredit:('IVL')
        #   kind: 'aptc_csr'
        #   authority_determination_identifier: 'fa_application_id'
        #   premium_credit_monthly_cap: '300.85'('max_aptc')
        #   sub_group_reference: 'fa_tax_household_id'
        #   expected_contribution_percentage: 0.0318('3.18')
        # GroupPremiumCredit:('FEHB'/'Congress')
        #   kind: 'employer_contribution'
        #   authority_determination_identifier: 'bs_benefit_application_id'
        #   premium_credit_monthly_cap: '300.85'('employer_contribution')
        #   sub_group_reference:('employee_only', 'employee_plus_one' or 'employee_plus_many')
        #   expected_contribution_percentage: 0.25
        # GroupPremiumCredit:('SHOP')
        #   kind: 'employer_contribution'
        #   authority_determination_identifier: 'bs_benefit_application_id'
        #   premium_credit_monthly_cap: '300.85'('employer_contribution')
        #   sub_group_reference: 'bs_benefit_package_id'
        #   expected_contribution_percentage: 0.25
      end
    end
  end
end
