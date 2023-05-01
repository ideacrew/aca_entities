# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity TaxHousehold
      class TaxHousehold < Dry::Struct
        attribute :TaxHouseholdCoverages, Types::Array.of(AcaEntities::Fdsh::H36::TaxHouseholdCoverage).meta(omittable: false)
      end
    end
  end
end
