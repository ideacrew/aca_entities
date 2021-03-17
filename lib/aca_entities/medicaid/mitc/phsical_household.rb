# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Mitc
      class PhysicalHousehold < Dry::Struct

        attribute :household,   Array.of(Household).meta(omitttable: false)

      end
    end
  end
end