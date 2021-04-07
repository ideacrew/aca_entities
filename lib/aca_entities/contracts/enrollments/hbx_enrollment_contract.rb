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
          required(:hbx_id).filled(:string)
          required(:effective_on).filled(:date)
          required(:aasm_state).filled(:string)
          required(:market_place_kind).filled(
            AcaEntities::Types::EnrollmentMarketPlaceKinds
          )
          required(:enrollment_period_kind).filled(
            AcaEntities::Types::EnrollmentKinds
          )
          required(:product_kind).filled(
            AcaEntities::Types::ProductKinds
          )
          required(:hbx_enrollment_members).array(:hash)
          optional(:is_active).maybe(:bool)
          optional(:terminated_on).maybe(:date)
          optional(:terminate_reason).maybe(:string)
          optional(:termination_submitted_on).maybe(:date)
          optional(:waiver_reason).maybe(:string)
          optional(:review_status).maybe(:string)
          optional(:external_enrollment).maybe(:bool)
          optional(:predecessor_enrollment).maybe(:hash)
          optional(:product).maybe(:hash)
          optional(:issuer_profile).maybe(:hash)
          optional(:coverage_household).maybe(:hash)
          optional(:family).maybe(:hash)
          optional(:household).maybe(:hash)
          optional(:special_enrollment_period).maybe(:hash)
          optional(:broker_agency).maybe(:hash)
          optional(:broker_role).maybe(:hash)
          optional(:elected_amount).maybe(:hash)
          optional(:elected_premium_credit).maybe(:hash)
          optional(:applied_premium_credit).maybe(:hash)
          optional(:elected_aptc_pct).maybe(:float)
          optional(:applied_aptc_amount).maybe(:hash)
          optional(:aggregate_aptc_amount).maybe(:hash)
          optional(:is_any_enrollment_member_outstanding).maybe(:bool)
          optional(:special_verification_period).maybe(:date)
          optional(:enrollment_signature).maybe(:string)
          optional(:consumer_role).maybe(:hash)
          optional(:resident_role).maybe(:hash)
          optional(:benefit_package).maybe(:hash)
          optional(:benefit_coverage_period).maybe(:hash)
          optional(:employee_role).maybe(:hash)
          optional(:benefit_group_assignment).maybe(:hash)
          optional(:benefit_sponsorship).maybe(:hash)
          optional(:sponsored_benefit_package).maybe(:hash)
          optional(:sponsored_benefit).maybe(:hash)
          optional(:rating_area).maybe(:hash)
          optional(:updated_by).maybe(:hash)
          optional(:timestamp).maybe(:hash)
        end

        rule(:terminated_on, :effective_on) do
          if key? && value
            key.failure('must be on or after effective_on.') if values[:terminated_on] < values[:effective_on]
          end
        end

        rule(:predecessor_enrollment) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Enrollments::HbxEnrollmentReferenceContract.new.call(value)
              key.failure(text: "invalid predecessor enrollment", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid predecessor enrollment. Expected a hash.")
            end
          end
        end

        rule(:product) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Products::ProductReferenceContract.new.call(value)
              key.failure(text: "invalid product", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid product. Expected a hash.")
            end
          end
        end

        rule(:issuer_profile) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Organizations::IssuerProfileReferenceContract.new.call(value)
              key.failure(text: "invalid issuer profile", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid issuer profile. Expected a hash.")
            end
          end
        end

        rule(:coverage_household) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Households::CoverageHouseholdReferenceContract.new.call(value)
              key.failure(text: "invalid coverage household", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid coverage_household. Expected a hash.")
            end
          end
        end

        rule(:family) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Families::FamilyReferenceContract.new.call(value)
              key.failure(text: "invalid family", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid family. Expected a hash.")
            end
          end
        end

        rule(:household) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Households::HouseholdReferenceContract.new.call(value)
              key.failure(text: "invalid household", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid household. Expected a hash.")
            end
          end
        end

        rule(:special_enrollment_period) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::EnrollmentPeriods::SpecialEnrollmentPeriodReferenceContract.new.call(value)
              key.failure(text: "invalid special enrollment period", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid special enrollment period. Expected a hash.")
            end
          end
        end

        rule(:broker_agency) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Organizations::BrokerAgencyProfileReferenceContract.new.call(value)
              key.failure(text: "invalid broker agency", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid broker agency. Expected a hash.")
            end
          end
        end

        rule(:broker_role) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Brokers::BrokerRoleContract.new.call(value)
              key.failure(text: "invalid broker role", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid broker role. Expected a hash.")
            end
          end
        end

        rule(:elected_amount) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrencyContract.new.call(value)
              key.failure(text: "invalid elected amount", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid elected amount. Expected a hash.")
            end
          end
        end

        rule(:elected_premium_credit) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrencyContract.new.call(value)
              key.failure(text: "invalid elected premium credit", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid elected premium credit. Expected a hash.")
            end
          end
        end

        rule(:applied_premium_credit) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrencyContract.new.call(value)
              key.failure(text: "invalid applied premium credit", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid applied premium credit. Expected a hash.")
            end
          end
        end

        rule(:applied_aptc_amount) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrencyContract.new.call(value)
              key.failure(text: "invalid applied aptc amount", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid applied aptc amount. Expected a hash.")
            end
          end
        end

        rule(:consumer_role) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::ConsumerRoleReferenceContract.new.call(value)
              key.failure(text: "invalid consumer role", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid consumer role. Expected a hash.")
            end
          end
        end

        rule(:resident_role) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::ResidentRoleReferenceContract.new.call(value)
              key.failure(text: "invalid resident role", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid resident role. Expected a hash.")
            end
          end
        end

        rule(:benefit_package) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::BenefitCatalogs::BenefitPackageReferenceContract.new.call(value)
              key.failure(text: "invalid benefit package", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid benefit package. Expected a hash.")
            end
          end
        end

        rule(:benefit_coverage_period) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::BenefitCatalogs::BenefitCoveragePeriodReferenceContract.new.call(value)
              key.failure(text: "invalid benefit coverage period", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid benefit coverage period. Expected a hash.")
            end
          end
        end

        rule(:updated_by) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::PersonReferenceContract.new.call(value)
              key.failure(text: "invalid updated by", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid updated by. Expected a hash.")
            end
          end
        end

        rule(:timestamp) do
          if key? && value
            if value.is_a?(Hash)
              result = TimeStampContract.new.call(value)
              key.failure(text: "invalid timestamp", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid timestamp. Expected a hash.")
            end
          end
        end

        rule(:hbx_enrollment_members).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Enrollments::HbxEnrollmentMemberContract.new.call(value)
              key.failure(text: "invalid hbx enrollment member", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid hbx enrollment member. Expected a hash.")
            end
          end
        end

        rule(:market_place_kind) do
          if key? && value
            case value
              when 'individual'
                key.failure(text: 'consumer_role_id field should be populated') if values[:consumer_role].nil? || !values[:consumer_role].is_a?(Hash)
              when 'coverall'
                key.failure(text: 'resident_role_id field should be populated') if values[:resident_role].nil? || !values[:resident_role].is_a?(Hash)
              when 'employer_sponsored', 'employer_sponsored_cobra'
                # TODO
            end
          end
        end

        # rule(:product_kind) do
        #   # Write rules based on coverage_kind
        #   if key? && value
        #     case value
        #     when 'health'
        #     when 'dental'
        #     end
        #   end
        # end

        rule(:enrollment_period_kind) do
          if key? && value
            case value
              when 'special_enrollment'
                key.failure(text: 'special_enrollment_period_id field should be populated') if values[:special_enrollment_period].nil? || !values[:special_enrollment_period].is_a?(Hash)
              when 'open_enrollment'
                # TODO
            end
          end
        end
      end
    end
  end
end


