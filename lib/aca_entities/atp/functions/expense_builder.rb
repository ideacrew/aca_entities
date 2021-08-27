# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/expense'
module AcaEntities
  module Atp
    module Functions
      # build application and applicants
      class ExpenseBuilder
        def call(cache)
          @memoized_data = cache
          applicants_hash = @memoized_data.resolve('family.magi_medicaid_applications.applicants').item
          member_id = @memoized_data.find(/family.family_members.(\w+)$/).map(&:item).last
          deductions = applicants_hash[member_id.to_sym][:deductions]

          deductions.each_with_object([]) do |deduction, collect|
            collect << ::AcaEntities::Atp::Transformers::Aces::Expense.transform(deduction)
          end
        end
      end
    end
  end
end
