# frozen_string_literal: true

module AcaEntities
  module Households
    class CoverageHouseholdReference < Dry::Struct

      attribute :start_date,                            Types::Date.optional.meta(omittable: true)
      attribute :end_date,                              Types::Date.optional.meta(omittable: true)
      attribute :is_immediate_family,                   Types::Bool.meta(omittable: false)
      attribute :is_determination_split_household,      Types::Bool.optional.meta(omittable: false)
    end
  end
end