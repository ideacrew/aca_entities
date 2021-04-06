# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class PhysicalHousehold < Dry::Struct

        attribute :household,   Types::Array.of(Household).meta(omitttable: false)

      end
    end
  end
end