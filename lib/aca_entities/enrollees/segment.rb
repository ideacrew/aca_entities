# frozen_string_literal: true

module AcaEntities
  module Enrollees
    # entity for enrollee demographics
    class Segment < Dry::Struct
      attribute :id,    Types::String.meta(omittable: false)
      attribute :effective_start_date,    Types::Date.meta(omittable: false)
      attribute :effective_end_date,    Types::Date.meta(omittable: false)
      attribute :individual_premium_amount,    Types::Float.optional.meta(omittable: true)
      attribute :individual_responsible_amount,  Types::Float.optional.meta(omittable: true)
      attribute :total_premiumum_amount,    Types::Float.optional.meta(omittable: true)
      attribute :total_responsible_amount,  Types::Float.optional.meta(omittable: true)
      attribute :aptc_amount,  Types::Float.optional.meta(omittable: true)
      attribute :csr_variant,   Types::String.optional.meta(omittable: true)
      attribute :partial_month_premium,   Types::Float.optional.meta(omittable: true)
      attribute :partial_month_aptc,   Types::Float.optional.meta(omittable: true)
      attribute :partial_month_start_date,    Types::Date.optional.meta(omittable: true)
      attribute :partial_month_end_date,    Types::Date.optional.meta(omittable: true)
    end
  end
end
