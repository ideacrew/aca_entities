# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for TaxReturn
      class TaxReturn < Dry::Struct
        attribute :tax_household_composition,   TaxHouseholdComposition.optional.meta(omittable: true)
        attribute :annual_income_information,   AnnualIncomeInformation.optional.meta(omittable: true)
        attribute :irs_information,             IrsInformation.optional.meta(omittable: true)
        attribute :tax_household_annual_income, TaxHouseholdAnnualIncome.optional.meta(omittable: true)
      end
    end
  end
end
