# frozen_string_literal: true

module AcaEntities
  module People
    class PersonDemographics < Dry::Struct

      attribute :ssn,                     Types::String.optional.meta(omittable: true)
      attribute :no_ssn,                  Types::Strict::Bool.optional.meta(omittable: true)
      attribute :gender,                  Types::String
      attribute :dob,                     Types::Date
      attribute :date_of_death,           Types::Date.optional.meta(omittable: true)
      attribute :dob_check,               Types::Date.optional.meta(omittable: true)
      attribute :is_incarcerated,         Types::Bool.optional.meta(omittable: true)
      attribute :ethnicity,               Types::Array.optional.meta(omittable: true)
      attribute :race,                    Types::String.optional.meta(omittable: true)
      attribute :tribal_id,               Types::String.optional.meta(omittable: true)
      attribute :language_code,           Types::String.optional.meta(omittable: true)
    end
  end
end