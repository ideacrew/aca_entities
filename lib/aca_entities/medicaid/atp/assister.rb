# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Assister
      class Assister < Dry::Struct
        attribute :role_played_by_person, RolePlayedByPerson.optional.meta(omittable: true)
      end
    end
  end
end