# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An outgoing monetary payment.
          class PersonExpense
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'PersonExpense'
            namespace 'hix-core'

            # A description of a kind of expense.
            element :category_text, String, tag: 'ExpenseCategoryText', namespace: "hix-core"

            # An amount of an expense.
            element :amount, Float, tag: 'ExpenseAmount', namespace: "hix-core"

            has_one :frequency, ExpenseFrequency

            # A kind of expense.
            element :category_code, String, tag: 'ExpenseCategoryCode', namespace: "hix-core"

            def self.domain_to_mapper(expense)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end