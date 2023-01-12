#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    class InsuranceProduct < Dry::Struct
      attribute :name,         Types::String.meta(omittable: false)
      attribute :hios_plan_id,    Types::String.meta(omittable: false)
      attribute :plan_year,    Types::Integer.meta(omittable: false)
      attribute :coverage_type,    Types::String.meta(omittable: false)
      attribute :metal_level,    Types::String.meta(omittable: false)
      attribute :market_type,    Types::String.meta(omittable: false)
      attribute :ehb,    Types::String.optional.meta(omittable: true)
    end
  end
end