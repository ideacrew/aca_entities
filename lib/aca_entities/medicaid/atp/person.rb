# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Person
      class Person < Dry::Struct
        attribute :id, Types::String.meta(omittable: false)
        attribute :age_measure, PersonAgeMeasure.optional.meta(omittable: true)
        attribute :birth_date, PersonBirthDate.optional.meta(omittable: true)
        attribute :ethnicities, Types::Array.of(Types::String).optional.meta(omittable: true)
        attribute :person_name, PersonName.meta(omittable: false)
        attribute :race, Types::String.optional.meta(omittable: true)
        attribute :sex, Types::String.meta(omittable: false)
        attribute :ssn_identification, PersonSsnIdentification.optional.meta(omittable: true)
        attribute :us_citizen_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :living_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :person_augmentation, PersonAugmentation.optional.meta(omittable: true)
        attribute :tribal_augmentation, TribalAugmentation.optional.meta(omittable: true)
      end
    end
  end
end
