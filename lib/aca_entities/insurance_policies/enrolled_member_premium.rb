#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    class EnrolledMemberPremium < Dry::Struct
      attribute :premium_schedule,        AcaEntities::InsurancePolicies::PremiumSchedule.optional.meta(omittable: true)
      attribute :insurance_rate, AcaEntities::Currency.optional.meta(omittable: true)
    end
  end
end