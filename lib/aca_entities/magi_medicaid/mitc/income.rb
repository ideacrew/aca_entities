# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class Income < Dry::Struct

        # @!attribute [r] amount
        # Wages, Salaries, Tips: person's income from work.
        # @return [Integer]
        attribute :amount,              Types::Integer.meta(omittible: false)

        # @!attribute [r] taxable_interest
        # Person's interest that is subject to taxation.
        # @return [Integer]
        attribute :taxable_interest,    Types::Integer.meta(omittible: false)

        # @!attribute [r] tax_exempt_interest
        # Person's interest that is not subject to taxation.
        # @return [Integer]
        attribute :tax_exempt_interest,    Types::Integer.meta(omittible: false)

        # @!attribute [r] taxable_refunds
        # Taxable Refunds, Credits, or Offsets of State and Local Income Taxes.
        # @return [Integer]
        attribute :taxable_refunds,    Types::Integer.meta(omittible: false)

        # @!attribute [r] alimony
        # Alimony paid.
        # @return [Integer]
        attribute :alimony,    Types::Integer.meta(omittible: false)

        # @!attribute [r] capital_gain_or_loss
        # Capital Gain or Loss.
        # @return [Integer]
        attribute :capital_gain_or_loss,    Types::Integer.meta(omittible: false)

        # @!attribute [r] pensions_and_annuities_taxable_amount
        # Pensions and Annuities Taxable Amount.
        # @return [Integer]
        attribute :pensions_and_annuities_taxable_amount,    Types::Integer.meta(omittible: false)

        # @!attribute [r] farm_income_or_loss
        # Farm Income or Loss.
        # @return [Integer]
        attribute :farm_income_or_loss,    Types::Integer.meta(omittible: false)

        # @!attribute [r] unemployment_compensation
        # Unemployment Compensation.
        # @return [Integer]
        attribute :unemployment_compensation,    Types::Integer.meta(omittible: false)

        # @!attribute [r] other_income
        # @return [Integer]
        attribute :other_income,    Types::Integer.meta(omittible: false)

        # @!attribute [r] magi_deductions
        # @return [Integer]
        attribute :magi_deductions,    Types::Integer.meta(omittible: false)

        # @!attribute [r] adjusted_gross_income
        # In the event the information is being built from last year's tax return,
        # it may be easier to calculate MAGI by starting with the AGI.  Expressed as an annual amount.
        # @return [Integer]
        attribute :adjusted_gross_income,    Types::Integer.meta(omittible: false)

        # @!attribute [r] deductible_part_of_self_employment_tax
        # Deductible Part of Self-Employment Tax
        # @return [Integer]
        attribute :deductible_part_of_self_employment_tax,    Types::Integer.meta(omittible: false)

        # @!attribute [r] ira_deduction
        # IRA Deduction.
        # @return [Integer]
        attribute :ira_deduction,    Types::Integer.meta(omittible: false)

        # @!attribute [r] student_loan_interest_deduction
        # Student Loan Interest Deduction.
        # @return [Integer]
        attribute :student_loan_interest_deduction,    Types::Integer.meta(omittible: false)

        # @!attribute [r] tution_and_fees
        # Tuition and Fees.
        # @return [Integer]
        attribute :tution_and_fees,    Types::Integer.meta(omittible: false)

        # @!attribute [r] other_magi_eligible_income
        # Other MAGI-Eligible Income.
        # @return [Integer]
        attribute :other_magi_eligible_income,    Types::Integer.meta(omittible: false)
      end
    end
  end
end
