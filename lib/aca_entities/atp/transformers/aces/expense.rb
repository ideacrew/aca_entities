# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Expense < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          ExpenseTypes = {
            'alimony_paid' => 'Alimony',
            'student_loan_interest' => 'StudentLoanInterest'
          }.freeze

          map 'amount', 'amount'
          map 'frequency_kind', 'frequency.frequency_code'
          map 'kind', 'category_code', function: lambda { |v|
            ExpenseTypes[v]
          }
        end
      end
    end
  end
end