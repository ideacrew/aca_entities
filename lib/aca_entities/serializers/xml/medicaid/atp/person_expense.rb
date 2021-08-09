# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An outgoing monetary payment.
          class PersonExpense
            include HappyMapper

            tag 'PersonExpense'
            namespace 'hix-core'

            # A description of a kind of expense.
            element :category_text, String, tag: 'ExpenseCategoryText', namespace: "hix-core"

            # An amount of an expense.
            element :amount, Float, tag: 'ExpenseAmount', namespace: "hix-core"

            has_one :frequency, ExpenseFrequency

            # A kind of expense.
            element :category_code, String, tag: 'ExpenseCategoryCode', namespace: "hix-core"

            def self.domain_to_mapper(person_expense)
              mapper = self.new
              mapper.category_text = person_expense.category_text
              mapper.amount = person_expense.amount
              mapper.frequency = ExpenseFrequency.domain_to_mapper(person_expense.frequency)
              mapper.category_code = person_expense.category_code
              mapper
            end

            def to_hash
              {
                category_text: category_text,
                amount: amount,
                frequency: frequency&.to_hash,
                category_code: category_code
              }
            end
          end
        end
      end
    end
  end
end