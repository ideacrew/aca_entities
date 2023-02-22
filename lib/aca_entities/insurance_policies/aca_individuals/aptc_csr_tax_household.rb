#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      class AptcCsrTaxHousehold < Dry::Struct
        attribute :hbx_assigned_id, Types::String.optional.meta(omittable: true)
        attribute :corrected, Types::Bool.optional.meta(omittable: true)
        attribute :void, Types::Bool.optional.meta(omittable: true)
        attribute :tax_household_members,
                  Types::Strict::Array.of(AcaEntities::Households::TaxHouseholdMember).meta(omittable: false)
        attribute :covered_individuals,
                  Types::Strict::Array.of(AcaEntities::InsurancePolicies::AcaIndividuals::CoveredIndividual).optional.meta(omittable: true)
        attribute :months_of_year,
                  Types::Strict::Array.of(AcaEntities::InsurancePolicies::AcaIndividuals::MonthOfYear).optional.meta(omittable: true)

        attribute :annual_premiums, AcaEntities::InsurancePolicies::AcaIndividuals::CoverageInformation.optional.meta(omittable: true)
      end
    end
  end
end
