# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Insurance Policy
      class InsurancePolicy < Dry::Struct

        attribute :member, InsuranceMember.optional.meta(omittable: true)
        attribute :policy_id, InsurancePolicyIdentification.optional.meta(omittable: true)
        attribute :premium, InsurancePremium.optional.meta(omittable: true)
        attribute :source_code, Types::InsuranceSourceCode.optional.meta(omittable: true)
        attribute :applied_effective_date_range, InsurancePolicyAppliedEffectiveDateRange.optional.meta(omittable: true)
      end
    end
  end
end
