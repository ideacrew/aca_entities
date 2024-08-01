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
            result = ::AcaEntities::Atp::Transformers::Aces::Expense.transform(deduction)
            category_text = construct_category_text(deduction)
            result.merge!(category_text: category_text) if category_text.present?
            collect << result
          end
        end

        def construct_category_text(deduction)
          return if deduction[:start_on].blank? && deduction[:end_on].blank?

          category_text = []
          category_text << "start:#{deduction[:start_on]}" if deduction[:start_on].present?
          category_text << "end:#{deduction[:end_on]}" if deduction[:end_on].present?
          category_text.join(',')
        end
      end
    end
  end
end
