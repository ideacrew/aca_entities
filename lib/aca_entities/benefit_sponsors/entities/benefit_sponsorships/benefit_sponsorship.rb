# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module BenefitSponsorships
      class BenefitSponsorship < Dry::Struct
        transform_keys(&:to_sym)
        include AcaEntities::Eligible::Eligible

        eligibility :shop_osse_eligibility,
                    class_name:
                      "AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseEligibility"

        attribute :_id, Types::String.optional
        attribute :hbx_id, Types::Strict::String
        attribute :profile_id, Types::Strict::String
        attribute :effective_begin_on, Types::Date.optional
        attribute :effective_end_on, Types::Date.optional
        attribute :termination_kind, Types::String.optional
        attribute :termination_reason, Types::String.optional
        attribute :predecessor_id, Types::String.optional
        attribute :source_kind, Types::Strict::Symbol
        attribute :registered_on, Types::Date.optional
        attribute :is_no_ssn_enabled, Types::Bool.optional
        attribute :ssn_enabled_on, Types::Date.optional
        attribute :ssn_disabled_on, Types::Date.optional
        attribute :aasm_state, Types::Strict::Symbol
        attribute :organization_id, Types::String.optional
        attribute :market_kind, Types::Strict::Symbol
      end
    end
  end
end
