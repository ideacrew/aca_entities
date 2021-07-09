# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp BirthDate
      class BirthDate < Dry::Struct

        attribute :date, Types::Date.optional.meta(omittable: true)
        attribute :date_time, Types::DateTime.optional.meta(omittable: true)
        attribute :year, Types::String.optional.meta(omittable: true)
        attribute :year_month, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
