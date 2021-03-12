# frozen_string_literal: true

module AcaEntities
  class Demographic < Dry::Struct

    attribute :dob, Types::Date
    attribute :gender, Types::String
    attribute :is_veteran_or_active_military, Types::Bool.optional.meta(omittable: true)
    attribute :age_of_applicant, Types::Integer.optional.meta(omittable: true)
    attribute :date_of_adoption, Types::Date.optional.meta(omittable: true)
    attribute :is_married, Types::Bool.optional.meta(omittable: true)
    attribute :race_name, Types::String.optional.meta(omittable: true)
    attribute :ethnicity_name, Types::String.optional.meta(omittable: true)
    attribute :is_hispanic_or_spanish_descent, Types::Bool.optional.meta(omittable: true)
  end
end
