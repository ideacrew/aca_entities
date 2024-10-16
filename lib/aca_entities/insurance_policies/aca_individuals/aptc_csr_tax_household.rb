#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      # Entity for {AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::AptcCsrTaxHouseholdContract} with attributes
      class AptcCsrTaxHousehold < Dry::Struct
        attribute :hbx_assigned_id, Types::String.optional.meta(omittable: true)
        attribute :primary_tax_filer_hbx_id, Types::String.optional.meta(omittable: true)
        attribute :corrected, Types::Bool.optional.meta(omittable: true)
        attribute :void, Types::Bool.optional.meta(omittable: true)
        attribute :tax_household_members,
                  Types::Strict::Array.of(AcaEntities::Households::TaxHouseholdMember).meta(omittable: false)
        attribute :covered_individuals,
                  Types::Strict::Array.of(AcaEntities::InsurancePolicies::AcaIndividuals::CoveredIndividual).optional.meta(omittable: true)
        attribute :months_of_year,
                  Types::Strict::Array.of(AcaEntities::InsurancePolicies::AcaIndividuals::MonthOfYear).optional.meta(omittable: true)

        attribute :annual_premiums, AcaEntities::InsurancePolicies::AcaIndividuals::CoverageInformation.optional.meta(omittable: true)

        def <=>(other)
          [
            primary_tax_filer_hbx_id,
            covered_individuals,
            months_of_year,
            annual_premiums
          ] <=> [
            other.primary_tax_filer_hbx_id,
            other.covered_individuals,
            other.months_of_year,
            other.annual_premiums
          ]
        end

        def tax_household_same_as?(tax_household)
          (self <=> tax_household) == 0
        end
      end
    end
  end
end
