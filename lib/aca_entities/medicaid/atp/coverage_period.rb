# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for atp CoveragePeriod.
      class CoveragePeriod < Dry::Struct

        attribute :start_date, Types::Date.optional.meta(omittable: true)
        attribute :start_reason_text, Types::String.optional.meta(omittable: true)
        attribute :end_date, Types::Date.optional.meta(omittable: true)
        attribute :end_reason_text, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
