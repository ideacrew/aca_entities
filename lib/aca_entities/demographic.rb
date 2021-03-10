# frozen_string_literal: true

module AcaEntities
  class Demographic < Dry::Struct

    attribute :dob, Types::Date
    attribute :gender, Types::String
    attribute :is_veteran_or_active_military, Types::Bool.optional.meta(omittable: true)
    attribute :age_of_applicant, Types::Integer.optional.meta(omittable: true)
  end
end
