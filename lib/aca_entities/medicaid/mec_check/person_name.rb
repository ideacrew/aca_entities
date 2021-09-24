# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      # entity for PersonName
      class PersonName < Dry::Struct
        attribute :first_name,  Types::String.meta(omittable: false)
        attribute :middle_name, Types::String.optional.meta(omittable: true)
        attribute :last_name,   Types::String.meta(omittable: false)
        attribute :name_suffix, Types::String.optional.meta(omittable: true)
      end
    end
  end
end