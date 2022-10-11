# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A date a lawfully present applicant document expires.
          class DocumentExpirationDate
            include HappyMapper

            tag 'LawfulPresenceDocumentExpirationDate'
            namespace 'hix-ee'

            element :date, Date, tag: "Date", namespace: "nc"
            element :date_time, DateTime, tag: "DateTime", namespace: "nc"
            element :year, String, tag: "Year", namespace: "nc"
            element :year_month, String, tag: "YearMonth", namespace: "nc"

            def self.domain_to_mapper(activity_date)
              mapper = self.new
              mapper.date = activity_date.date
              mapper.date_time = activity_date.date_time
              mapper.year = activity_date.year
              mapper.year_month = activity_date.year_month
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