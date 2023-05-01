# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity IrsHouseholdGroup
      class IrsHouseholdGroup < Dry::Struct
        attribute :IrsGroupIdentificationNumber, AcaEntities::Types::String.meta(omittable: false)
        attribute :TaxHouseholds, Types::Array.of(AcaEntities::Fdsh::H36::TaxHousehold).meta(omittable: false)
        attribute :InsurancePolicies, Types::Array.of(AcaEntities::Fdsh::H36::InsurancePolicy).meta(omittable: false)
      end
    end
  end
end
