# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an Household.
          class Household
            include HappyMapper

            tag 'Household'

            has_one :PrimaryGroup, PrimaryGroup
            has_one :SpouseGroup, SpouseGroup
            has_many :DependentGroups, DependentGroup
            has_many :AssociatedPolicies, AssociatedPolicy

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.PrimaryGroup = PrimaryGroup.domain_to_mapper(request.PrimaryGroup)
              mapper.SpouseGroup = SpouseGroup.domain_to_mapper(request.SpouseGroup) if request.SpouseGroup
              if request.DependentGroups
                mapper.DependentGroups = request.DependentGroups.collect do |dependent_group|
                  DependentGroup.domain_to_mapper(dependent_group)
                end
              end

              mapper.AssociatedPolicies = request.AssociatedPolicies.collect do |associated_policy|
                AssociatedPolicy.domain_to_mapper(associated_policy)
              end

              mapper
            end
          end
        end
      end
    end
  end
end