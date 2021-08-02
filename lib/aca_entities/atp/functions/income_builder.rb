# frozen_string_literal: true
require 'aca_entities/atp/transformers/aces/income_transform'

module AcaEntities
  module Atp
    module Functions
      # build application and applicants
      class IncomeBuilder
        def call(cache)
          @memoized_data = cache

          applicants_hash = @memoized_data.resolve('family.magi_medicaid_applications.applicants').item
          # "family.family_members.1234.person.person_relationship"
          member_id = @memoized_data.find(/family.family_members.(\w+)$/).map(&:item).last
          # member_id = @memoized_data.find(Regexp.new("family.family_members.*")).last.item
          incomes = applicants_hash[member_id.to_sym][:incomes]

          
          result = incomes.each_with_object([]) do |income, collect|
            # atp_income = ::AcaEntities::Atp::Transformers::Atp::IncomeTransform.transform(income)
             { :employment_source_text => nil,
                           :amount => income[:amount],
                           :days_per_week => nil,
                           :hours_per_pay_period => nil,
                           :hours_per_week => income[:hours_per_week],
                           :category_code => income[:kind],
                           :description_text => nil,
                           :subject_to_federal_restrictions_indicator => nil,
                           :date => nil,
                           :earned_date_range => { :end_date => { :date => income[:end_on], :date_time => "", :year => nil, :year_month => nil },
                                                   :start_date => { :date => income[:start_on], :date_time => "", :year => nil,
                                                                    :year_month => nil } },
                           :frequency => { :frequency_code => income[:frequency_kind] },
                           :payment_frequency => nil,
                           :source_organization_reference=>{:ref=> income[:employer_id]} }

                           
            collect << atp_income
          end

          result
        end
      end
    end
  end
end
