# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Person
      class Person < Dry::Struct

        attribute :person_name, PersonName.meta(omittable: false)
        attribute :ssn, Types::String.meta(omittable: false)
        attribute :sex, Types::String.meta(omittable: false)
        attribute :race, Types::String.optional.meta(omittable: true)
        attribute :ethnicity, Types::Strict::Array.optional.meta(omittable: true)
        attribute :birth_date, BirthDate.optional.meta(omittable: true) 
        attribute :augmentation, PersonAugmentation.optional.meta(omittable: true)        
      end
    end
  end
end
