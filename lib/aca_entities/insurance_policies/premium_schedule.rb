#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    class PremiumSchedule < Dry::Struct
      attribute :premium_amount, AcaEntities::Currency.optional.meta(omittable: true)
      attribute :insured_start_on, Types::Date.optional.meta(omittable: true)
      attribute :insured_end_on, Types::Date.optional.meta(omittable: true)
      attribute :valid_start_on, Types::Date.optional.meta(omittable: true)
      attribute :valid_end_on, Types::Date.optional.meta(omittable: true)
      attribute :due_on, Types::Date.optional.meta(omittable: true)
    end
  end
end