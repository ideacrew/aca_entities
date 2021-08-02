# frozen_string_literal: true

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

            result = deductions.each_with_object([]) do |deduction, collect|
              atp_expense = {:category_text=>nil, 
                :amount=> deduction[:amount], 
                :frequency=>{:frequency_code=> deduction[:frequency_kind]}, 
                :category_code=> deduction[:kind]}
  
              collect << atp_expense
            end
            result
          end
        end
      end
    end
  end
  