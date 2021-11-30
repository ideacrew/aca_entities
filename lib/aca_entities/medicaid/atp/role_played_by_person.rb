# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp RolePlayedByPerson
      class RolePlayedByPerson < Dry::Struct

        attribute :person_name, PersonName.meta(omittable: false)
        attribute :birth_date, PersonBirthDate.optional.meta(omittable: true)
        attribute :sex, Types::String.meta(omittable: false)
        attribute :person_augmentation, PersonAugmentation.optional.meta(omittable: true)
      end
    end
  end
end
