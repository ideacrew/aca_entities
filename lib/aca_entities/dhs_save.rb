# frozen_string_literal: true

module AcaEntities
  # Entity for DhsSave.
  class DhsSave < Dry::Struct

    attribute :class_of_admission_code,  Types::String.optional.meta(omittable: true)
    attribute :admission_end_date,       Types::Date.optional.meta(omittable: true)
  end
end
