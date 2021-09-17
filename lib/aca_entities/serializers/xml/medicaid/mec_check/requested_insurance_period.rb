# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of a RequestedInsurancePeriod.
          class RequestedInsurancePeriod
            include HappyMapper

            tag 'RequestedInsurancePeriod'
            namespace 'gov'

            element :start_date, Date, tag: "StartDate", namespace: "gov"
            element :end_date, Date, tag: "EndDate", namespace: "gov"

            def self.domain_to_mapper(range)
              mapper = self.new
              mapper.start_date = info.start_date
              mapper.end_date = info.end_date
              mapper
            end

            def to_hash()
              {
                end_date: end_date,
                start_date: start_date
              }
            end
          end
        end
      end
    end
  end
end