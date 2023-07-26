# frozen_string_literal: true

module AcaEntities
  module Cms
    module Pbp
      class FinancialInformation < Dry::Struct
        attribute :financial_effective_start_date, AcaEntities::Types::Date.meta(omittable: false)
        attribute :financial_effective_end_date, AcaEntities::Types::Date.meta(omittable: false)
        attribute :monthly_premium_amount, AcaEntities::Types::Money.meta(omittable: false)
        attribute :monthly_responsible_amount, AcaEntities::Types::Money.meta(omittable: false)
        attribute :monthly_aptc_amount, AcaEntities::Types::Money.optional.meta(omittable: true)
        attribute :monthly_csr_amount, AcaEntities::Types::Money.optional.meta(omittable: true)
        attribute :csr_variant, AcaEntities::Types::String.optional.meta(omittable: true)
        attribute :prorated_amounts, AcaEntities::Types::Array.of(AcaEntities::Cms::Pbp::ProratedAmount).optional.meta(omittable: true)
        attribute :rating_area, AcaEntities::Types::String.optional.meta(omittable: true)
      end
    end
  end
end
