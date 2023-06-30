# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module BenefitSponsorships
      class BenefitSponsorship < Dry::Struct
        transform_keys(&:to_sym)
        include AcaEntities::Eligible::Eligible

        # eligibility :aca_shop_osse_eligibility, class_name: 'AcaEntities::BenefitSponsors::AcaShopOsseEligibility::Eligibility'
        # eligibility :shop_osse_eligibility, class_name: 'ShopOsseEligibility::Eligibility'
        eligibility :shop_osse_eligibility,
                    class_name:
                      'AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::Eligibility'

        attribute :_id, Types::Bson
        attribute :hbx_id, Types::Strict::String
        attribute :profile_id, Types::Bson
        attribute :effective_begin_on, Types::Date.optional
        attribute :effective_end_on, Types::Date.optional
        attribute :termination_kind, Types::String.optional
        attribute :termination_reason, Types::String.optional
        attribute :predecessor_id, Types::Bson.optional
        attribute :source_kind, Types::Strict::Symbol
        attribute :registered_on, Types::Date.optional
        attribute :is_no_ssn_enabled, Types::Bool.optional
        attribute :ssn_enabled_on, Types::Date.optional
        attribute :ssn_disabled_on, Types::Date.optional
        attribute :aasm_state, Types::Strict::Symbol
        attribute :organization_id, Types::Bson
        attribute :market_kind, Types::Strict::Symbol

        attribute :benefit_applications,
                  Types::Array.of(BenefitSponsors::BenefitApplication)
      end
    end
  end
end

# 1. Create Eligibility mixin
# 2. Create Evidence mixin

# class BenefitSponsorship < Dry::Struct
#   include Eligible::Eligible

#   eligibility :shop_osse_eligibility, class_name: 'Eligible::ShopOsseEligibility' # Hash
#   eligibility :aptc_csr_eligibility, class_name: 'Eligible::AptcCsrEligibility'

#   # eligibility :aptc_csr_eligibility, class_name: 'Eligible::AptcCsrEligibility'

# end

# module Eligible
#   class ShopOsseEligibility < Dry::Struct
#     include Eligible::Eligible
#     include Eligible::Eligibility

#     attribute :due_on # additional attributes

#     evidence :shop_osse_evidence, class_name: 'Eligible::ShopOsseEvidence'
#     grant :shop_osse_grant, class_name: 'Eligible::ShopOsseGrant'
#   end
# end

# module Eligible
#   class ShopOsseEvidence < Dry::Struct
#     include Eligible::Evidence

#   end
# end

# module Eligible
#   class ShopOsseGrant < Dry::Struct
#     include Eligible::Grant

#   end
# end
