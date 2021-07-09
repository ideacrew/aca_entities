# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class EndDate
            include HappyMapper

            tag 'EndDate'
            namespace 'nc'

            element :date, Date, tag: "Date", namespace: "nc"
            element :date_time, DateTime, tag: "DateTime", namespace: "nc"
            element :year, String, tag: "Year", namespace: "nc"
            element :year_month, String, tag: "YearMonth", namespace: "nc"

            def self.domain_to_mapper(end_date)
              mapper = self.new
              mapper.date = end_date.date
              # mapper.date_time = ed.date_time
              # mapper.year = ed.year
              # mapper.year_month = ed.year_month
              mapper
            end

            def to_hash
              {
                date: date.to_s,
                date_time: date_time.to_s,
                year: year,
                year_month: year_month
              }
            end
          end
        end
      end
    end
  end
end