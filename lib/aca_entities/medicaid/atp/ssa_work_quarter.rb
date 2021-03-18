# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for SsaWorkQuarter.
      class SsaWorkQuarter < Dry::Struct

        # The year in which quarters were earned..
        attribute :work_year_date,   Types::Date.optional.meta(omittable: true)
        attribute :quarters_earned,  Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end
