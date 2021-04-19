# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::Income}
        class IncomeContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :amount required
          # @option opts [Integer] :taxable_interest required
          # @option opts [Integer] :tax_exempt_interest required
          # @option opts [Integer] :alimony required
          # @option opts [Integer] :capital_gain_or_loss required
          # @option opts [Integer] :pensions_and_annuities_taxable_amount required
          # @option opts [Integer] :farm_income_or_loss required
          # @option opts [Integer] :unemployment_compensation required
          # @option opts [Integer] :other_income required
          # @option opts [Integer] :magi_deductions required
          # @option opts [Integer] :adjusted_gross_income required
          # @option opts [Integer] :deductible_part_of_self_employment_tax required
          # @option opts [Integer] :ira_deduction required
          # @option opts [Integer] :student_loan_interest_deduction required
          # @option opts [Integer] :tution_and_fees required
          # @option opts [Integer] :other_magi_eligible_income required
          # @return [Dry::Monads::Result]
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
