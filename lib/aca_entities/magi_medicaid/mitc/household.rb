# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class Household < Dry::Struct

        attribute :household_id,  Types::String.meta(omitttable: false)
        attribute :people,        Types::Array.of(PersonReference).meta(omitttable: false)

      end
    end
  end
end