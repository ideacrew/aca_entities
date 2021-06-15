# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class PersonBirthDate
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'PersonBirthDate'
            namespace 'nc'

            element :date, Date, tag: "Date", namespace: "nc"
            element :date_time, DateTime, tag: "DateTime", namespace: "nc"
            element :year, String, tag: "Year", namespace: "nc"
            element :year_month, String, tag: "YearMonth", namespace: "nc"

            def self.domain_to_mapper(date_time)
              mapper = self.new
              mapper.date_time = date_time
              mapper
            end
          end
        end
      end
    end
  end
end