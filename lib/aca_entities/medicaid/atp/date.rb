# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # base class for atp date types
      class Date < Dry::Struct

        attribute :date, Types::Date.optional.meta(omittable: true)
        attribute :date_time, Types::DateTime.optional.meta(omittable: true)
        attribute :year, Types::String.optional.meta(omittable: true)
        attribute :year_month, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
