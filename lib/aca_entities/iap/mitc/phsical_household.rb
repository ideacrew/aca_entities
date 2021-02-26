# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      class PhysicalHousehold < Dry::Struct

        attribute :household,   Array.of(Household).meta(omitttable: false)

      end
    end
  end
end