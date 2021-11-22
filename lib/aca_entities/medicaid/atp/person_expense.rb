# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonExpense
      class PersonExpense < Dry::Struct
        attribute :category_text, Types::String.optional.meta(omittable: true)
        attribute :amount, Types::Float.optional.meta(omittable: true)
        attribute :frequency, ExpenseFrequency.optional.meta(omittable: true)
        attribute :category_code, Types::ExpenseCategoryCode.optional.meta(omittable: true)
      end
    end
  end
end