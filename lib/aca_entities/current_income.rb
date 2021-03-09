# frozen_string_literal: true

module AcaEntities
  # Entity for CurrentIncome.
  class CurrentIncome < Dry::Struct

    attribute :most_recent_hire_date,  Types::Date.optional.meta(omittable: true)
    attribute :termination_date,       Types::Date.optional.meta(omittable: true)
  end
end
