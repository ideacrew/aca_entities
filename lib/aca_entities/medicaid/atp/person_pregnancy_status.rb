# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonPregnancyStatus
      class PersonPregnancyStatus < Dry::Struct

        attribute :status_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :status_valid_date_range, StatusValidDateRange.optional.meta(omittable: true)
        attribute :expected_baby_quantity, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end