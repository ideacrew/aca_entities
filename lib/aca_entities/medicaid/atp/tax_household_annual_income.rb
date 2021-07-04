# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp TaxHouseholdAnnualIncome
      class TaxHouseholdAnnualIncome < Dry::Struct

        attribute :annual_tax_household_income, Types::Money.optional.meta(omittable: true)
        attribute :tax_household_size, Types::Integer.optional.meta(omittable: true)
        attribute :computed_fpl, Types::Money.optional.meta(omittable: true)

        # Verification Group
        attribute :annual_income_discrepancy_answer_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :annual_income_discrepancy_reason, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
