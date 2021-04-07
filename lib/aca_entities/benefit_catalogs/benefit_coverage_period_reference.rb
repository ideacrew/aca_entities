# frozen_string_literal: true

module AcaEntities
  module BenefitCatalogs
    class BenefitCoveragePeriodReference < Dry::Struct

      attribute :title,                           Types::String.meta(omittable: false)
      attribute :market_place,                    Types::String.meta(omittable: false)
      attribute :start_on,                        Types::Date.meta(omittable: false)
      attribute :end_on,                          Types::Date.meta(omittable: false)
      attribute :open_enrollment_start_on,        Types::Date.meta(omittable: false)
      attribute :open_enrollment_end_on,          Types::Date.meta(omittable: false)
    end
  end
end