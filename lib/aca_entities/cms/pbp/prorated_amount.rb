# frozen_string_literal: true

module AcaEntities
  module Cms
    module Pbp
      class ProratedAmount < Dry::Struct
        attribute :partial_month_premium, AcaEntities::Types::Money.meta(omittable: false)
        attribute :partial_month_aptc, AcaEntities::Types::Money.optional.meta(omittable: true)
        attribute :partial_month_csr, AcaEntities::Types::String.optional.meta(omittable: true)
        attribute :partial_month_start_date, AcaEntities::Types::Date.meta(omittable: false)
        attribute :partial_month_end_date, AcaEntities::Types::Date.meta(omittable: false)
      end
    end
  end
end
