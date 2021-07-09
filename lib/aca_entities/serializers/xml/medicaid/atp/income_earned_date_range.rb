# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # xml mapping for Atp::IncomeEarnedDateRange
          class IncomeEarnedDateRange
            include HappyMapper

            tag 'IncomeEarnedDateRange'
            namespace 'hix-core'

            has_one :start_date, StartDate
            has_one :end_date, EndDate

            def self.domain_to_mapper(income_earned_date_range)
              mapper = self.new
              mapper.end_date = EndDate.domain_to_mapper(income_earned_date_range.end_date)
              mapper.start_date = StartDate.domain_to_mapper(income_earned_date_range.start_date)
              mapper
            end

            def to_hash
              {
                end_date: end_date&.to_hash,
                start_date: start_date&.to_hash
              }
            end
          end
        end
      end
    end
  end
end