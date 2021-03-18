# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Contract for Income.
        class IncomeContract < Dry::Validation::Contract

          params do
            required(:amount).filled(:integer)
            required(:taxable_interest).filled(:integer)
            required(:tax_exempt_interest).filled(:integer)
            required(:taxable_refunds).filled(:integer)
            required(:alimony).filled(:integer)
            required(:capital_gain_or_loss).filled(:integer)
            required(:pensions_and_annuities_taxable_amount).filled(:integer)
            required(:farm_income_or_loss).filled(:integer)
            required(:unemployment_compensation).filled(:integer)
            required(:other_income).filled(:integer)
            required(:magi_deductions).filled(:integer)
            required(:adjusted_gross_income).filled(:integer)
            required(:deductible_part_of_self_employment_tax).filled(:integer)
            required(:ira_deduction).filled(:integer)
            required(:student_loan_interest_deduction).filled(:integer)
            required(:tution_and_fees).filled(:integer)
            required(:other_magi_eligible_income).filled(:integer)
          end
        end
      end
    end
  end
end
