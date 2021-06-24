# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class PhysicalHousehold
            include HappyMapper

            tag 'PhysicalHousehold'
            namespace 'ext'

            has_many :household_member_references, HouseholdMemberReference
            element :household_size_quantity, Integer, tag: 'HouseholdSizeQuantity', namespace: 'hix-ee'

            def self.domain_to_mapper(household)
              self.new
            end

            def to_hash
              {
                household_member_references: household_member_references.map(&:to_hash),
                household_size_quantity: household_size_quantity
              }
            end
          end
        end
      end
    end
  end
end