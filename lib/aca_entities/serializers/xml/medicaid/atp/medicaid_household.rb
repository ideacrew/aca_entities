# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a collection of persons to be treated as a household unit under a state's Medicaid rules.
          class MedicaidHousehold
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'MedicaidHousehold'
            namespace 'hix-ee'

            # A  number of persons in a household based on a state's Medicaid rules.
            element :effective_person_quantity, Integer, tag: 'MedicaidHouseholdEffectivePersonQuantity'

            # True if a household's income is greater than the highest applicable MAGI standard for the household size; false otherwise
            element :income_above_highest_applicable_magi_standard_indicator, Boolean,
                    tag: 'MedicaidHouseholdIncomeAboveHighestApplicableMAGIStandardIndicator'

            has_many :household_member_references, HouseholdMemberReference

            element :household_size_quantity, Integer, tag: 'HouseholdSizeQuantity'

            def self.domain_to_mapper(_date_time)
              self.new
            end
          end
        end
      end
    end
  end
end