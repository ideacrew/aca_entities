# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/income'

module AcaEntities
  module Atp
    module Functions
      # build application and applicants
      class IncomeBuilder
        def call(cache)
          @memoized_data = cache
          applicants_hash = @memoized_data.resolve('family.magi_medicaid_applications.applicants').item
          member_id = @memoized_data.find(/family.family_members.(\w+)$/).map(&:item).last
          incomes = applicants_hash[member_id.to_sym][:incomes]

          incomes.each_with_object([]) do |income, collect|
            next if income[:kind] == "american_indian_and_alaskan_native"
            atp_income = ::AcaEntities::Atp::Transformers::Aces::Income.transform(income)
            collect << atp_income
          end
        end
      end
    end
  end
end
