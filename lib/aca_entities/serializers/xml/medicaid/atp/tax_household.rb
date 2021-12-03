# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a collection of persons to be treated as a household unit for tax purposes.
          class TaxHousehold
            include HappyMapper

            tag 'TaxHousehold'
            namespace 'hix-ee'

            # A monetary payment received by a household, usually on a regular basis.
            has_many :household_incomes, HouseholdIncome

            # A count of the number of persons in a household.
            element :household_size_quantity, Integer, tag: 'HouseholdSizeQuantity', namespace: "hix-ee"

            has_one :primary_tax_filer, PrimaryTaxFiler

            has_one :spouse_tax_filer, SpouseTaxFiler

            has_many :tax_dependents, TaxDependent

            has_many :household_member_references, HouseholdMemberReference

            # True if the tax return includes dependents; false otherwise
            element :household_size_change_expected_indicator, Boolean, tag: 'HouseholdSizeChangeExpectedIndicator', namespace: "hix-ee"

            def self.domain_to_mapper(household)
              mapper = self.new
              mapper.household_size_quantity = household.household_size_quantity
              mapper.household_size_change_expected_indicator = household.household_size_change_expected_indicator
              mapper.household_incomes = household.household_incomes&.map { |income| HouseholdIncome.domain_to_mapper(income) }
              mapper.tax_dependents = household.tax_dependents&.map { |td| TaxDependent.domain_to_mapper(td) }
              mapper.household_member_references = household.household_member_references&.map { |hmr| HouseholdMemberReference.domain_to_mapper(hmr) }
              mapper.primary_tax_filer = PrimaryTaxFiler.domain_to_mapper(household.primary_tax_filer) if household.primary_tax_filer
              mapper.spouse_tax_filer = SpouseTaxFiler.domain_to_mapper(household.spouse_tax_filer) if household.spouse_tax_filer
              mapper
            end

            def to_hash
              {
                household_size_quantity: household_size_quantity,
                household_size_change_expected_indicator: household_size_change_expected_indicator,
                household_incomes: household_incomes.map(&:to_hash),
                tax_dependents: tax_dependents.map(&:to_hash),
                household_member_references: household_member_references.map(&:to_hash),
                primary_tax_filer: primary_tax_filer&.to_hash,
                spouse_tax_filer: spouse_tax_filer&.to_hash
              }
            end
          end
        end
      end
    end
  end
end