# frozen_string_literal: true

module AcaEntities
  module Enrollees
    # entity for enrollee demographics
    class EnrolleeDemographics < Dry::Struct
      attribute :dob,    Types::Date.meta(omittable: false)
      attribute :ssn,     Types::String.optional.meta(omittable: true)
      attribute :gender_code,   Types::String.meta(omittable: false)
      attribute :tobacco_use_code, Types::String.optional.meta(omittable: true)
    end
  end
end
