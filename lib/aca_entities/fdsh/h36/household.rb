# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity Household
      class Household < Dry::Struct
        attribute :PrimaryGroup, AcaEntities::Fdsh::H36::PrimaryGroup.meta(omittable: false)
        attribute :SpouseGroup, AcaEntities::Fdsh::H36::SpouseGroup.optional.meta(omittable: true)
        attribute :DependentGroups, Types::Array.of(AcaEntities::Fdsh::H36::DependentGroup).optional.meta(omittable: true)
        attribute :AssociatedPolicies, Types::Array.of(AcaEntities::Fdsh::H36::AssociatedPolicy).optional.meta(omittable: true)
      end
    end
  end
end
