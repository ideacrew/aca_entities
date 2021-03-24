# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonName
      class PersonName < Dry::Struct

        attribute :first_name, Types::String
        attribute :middle_name, Types::String.optional.meta(omittable: true)
        attribute :last_name, Types::String
        attribute :name_sfx, Types::String.optional.meta(omittable: true)
        attribute :name_pfx, Types::String.optional.meta(omittable: true)
        attribute :start_on, Types::Date.optional.meta(omittable: true)
        attribute :end_on, Types::Date.optional.meta(omittable: true)
      end
    end
  end
end
