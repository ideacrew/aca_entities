# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Enrollments
      # Schema and validation rules for {AcaEntities::Enrollments::HbxEnrollment}
      class HbxEnrollmentContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [Date] :effective_on required
        # @option opts [String] :aasm_state required
        # @option opts [String] :market_place_kind required
        # @option opts [String] :enrollment_period_kind required
        # @option opts [Hash] :product_kind required
        # @option opts [Hash] :hbx_enrollment_members required
        # @option opts [Boolean] :is_active optional
        # @option opts [Date] :terminated_on optional
        # @option opts [String] :terminate_reason optional
        # @option opts [Date] :termination_submitted_on optional
        # @option opts [String] :waiver_reason optional
        # @option opts [String] :review_status optional
        # @option opts [Boolean] :external_enrollment optional
        # @option opts [Hash] :predecessor_enrollment optional
        # @option opts [Hash] :product optional
        # @option opts [Hash] :issuer_profile optional
        # @option opts [Hash] :coverage_household optional
        # @option opts [Hash] :family optional
        # @option opts [Hash] :household optional
        # @option opts [Hash] :special_enrollment_period optional
        # @option opts [Hash] :elected_amount optional
        # @option opts [Hash] :elected_premium_credit optional
        # @option opts [Hash] :total_premium optional
        # @option opts [Hash] :applied_premium_credit optional
        # @option opts [Hash] :applied_aptc_amount optional
        # @option opts [Flaot] :elected_aptc_pct optional
        # @option opts [Hash] :aggregate_aptc_amount optional
        # @option opts [Boolean] :is_any_enrollment_member_outstanding optional
        # @option opts [Date] :special_verification_period optional
        # @option opts [String] :enrollment_signature optional
        # @option opts [Hash] :consumer_role optional
        # @option opts [Hash] :resident_role optional
        # @option opts [Hash] :benefit_package optional
        # @option opts [Hash] :benefit_coverage_period optional
        # @option opts [Hash] :employee_role optional
        # @option opts [Hash] :benefit_group_assignment optional
        # @option opts [Hash] :benefit_sponsorship optional
        # @option opts [Hash] :sponsored_benefit_package optional
        # @option opts [Hash] :sponsored_benefit optional
        # @option opts [Hash] :rating_area optional
        # @option opts [Hash] :updated_by optional
        # @option opts [Hash] :timestamp optional
        # @return [Dry::Monads::Result]
        params do
          optional(:hbx_id).maybe(:string)
          required(:effective_on).filled(:date)
          required(:aasm_state).filled(:string)
          required(:market_place_kind).filled(
            AcaEntities::Types::EnrollmentMarketPlaceKind
          )
          required(:enrollment_period_kind).filled(
            AcaEntities::Types::EnrollmentKind
          )
          required(:product_kind).filled(
            AcaEntities::Types::ProductKind
          )
          required(:hbx_enrollment_members).array(AcaEntities::Contracts::Enrollments::HbxEnrollmentMemberContract.params)
          required(:product_reference).hash(AcaEntities::Contracts::Products::ProductReferenceContract.params)
          required(:issuer_profile_reference).maybe(AcaEntities::Contracts::Organizations::IssuerProfileReferenceContract.params)

          optional(:is_active).maybe(:bool)
          optional(:terminated_on).maybe(:date)
          optional(:terminate_reason).maybe(:string)
          optional(:termination_submitted_on).maybe(:date)
          optional(:waiver_reason).maybe(:string)
          optional(:review_status).maybe(:string)
          optional(:external_enrollment).maybe(:bool)
          optional(:external_id).maybe(:string)
          optional(:external_group_identifiers).maybe(:array)
          optional(:predecessor_enrollment).hash(AcaEntities::Contracts::Enrollments::HbxEnrollmentReferenceContract.params)

          optional(:coverage_household_reference).hash(AcaEntities::Contracts::Households::CoverageHouseholdReferenceContract.params)
          optional(:family_hbx_id).maybe(:string)
          optional(:special_enrollment_period_reference).hash(
            AcaEntities::Contracts::EnrollmentPeriods::SpecialEnrollmentPeriodReferenceContract.params
          )
          optional(:broker_agency_reference).hash(AcaEntities::Contracts::Organizations::BrokerAgencyProfileReferenceContract.params)
          optional(:broker_role_reference).hash(AcaEntities::Contracts::Brokers::BrokerRoleReferenceContract.params)

          optional(:elected_amount).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:elected_premium_credit).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:applied_premium_credit).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:total_premium).maybe(:float)
          optional(:elected_aptc_pct).maybe(:float)
          optional(:applied_aptc_amount).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:aggregate_aptc_amount).hash(AcaEntities::Contracts::CurrencyContract.params)

          optional(:is_receiving_assistance).maybe(:bool)
          optional(:is_any_enrollment_member_outstanding).maybe(:bool)
          optional(:special_verification_period).maybe(:date)
          optional(:enrollment_signature).maybe(:string)

          optional(:consumer_role_reference).hash(AcaEntities::Contracts::People::ConsumerRoleReferenceContract.params)
          optional(:resident_role_reference).maybe(AcaEntities::Contracts::People::ResidentRoleReferenceContract.params)  # TODO: revisit
          optional(:benefit_package_reference).hash(AcaEntities::Contracts::BenefitCatalogs::BenefitPackageReferenceContract.params)
          optional(:benefit_coverage_period_reference).hash(AcaEntities::Contracts::BenefitCatalogs::BenefitCoveragePeriodReferenceContract.params)
          optional(:tax_households_references).array(AcaEntities::Contracts::PremiumCredits::TaxHouseholdEnrollmentContract.params)

          # TODO: Add shop contracts
          # optional(:employee_role_reference).filled(:hash)
          # optional(:benefit_group_assignment_reference).filled(:hash)
          # optional(:benefit_sponsorship_reference).filled(:hash)
          # optional(:sponsored_benefit_package_reference).filled(:hash)
          # optional(:sponsored_benefit_reference).filled(:hash)
          optional(:rating_area).maybe(:string)

          optional(:updated_by).hash(AcaEntities::Contracts::People::PersonReferenceContract.params)
          optional(:timestamp).hash(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
