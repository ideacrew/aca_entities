# frozen_string_literal: true

module AcaEntities
  class PersonDescriptionIdentifier < Dry::Struct
    attribute :is_full_time_student, Types::Bool.optional.meta(omittable: true)
  end
end
