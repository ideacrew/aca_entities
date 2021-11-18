# frozen_string_literal: true

module AcaEntities
  module Enrollees
    # entity for enrollee demographics
    class Segment < Dry::Struct
      attribute :id,    Types::String.meta(omittable: false)
      attribute :effective_start_date,    Types::Date.meta(omittable: false)
      attribute :effective_end_date,    Types::Date.meta(omittable: false)
      attribute :premium_amount,    Types::Decimal.optional.meta(omittable: true)
      attribute :responsible_amount,  Types::Decimal.optional.meta(omittable: true)
      attribute :aptc_amount,  Types::Decimal.optional.meta(omittable: true)
      attribute :csr_variant,   Types::String.meta(omittable: false)
      attribute :partial_month_premium,   Types::Decimal.optional.meta(omittable: true)
      attribute :partial_month_aptc,   Types::Decimal.optional.meta(omittable: true)
      attribute :partial_month_start_date,    Types::Date.meta(omittable: false)
      attribute :partial_month_end_date,    Types::Date.meta(omittable: false)
    end
  end
end
