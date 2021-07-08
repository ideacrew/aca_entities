# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # xml mapping for Atp::PersonPregnancyStatus
          class PersonPregnancyStatus
            include HappyMapper

            tag 'PersonPregnancyStatus'
            namespace 'hix-core'

            
            has_one :status_valid_date_range, StatusValidDateRange
            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "hix-core"
            element :expected_baby_quantity, Integer, tag: 'PregnancyStatusExpectedBabyQuantity', namespace: 'hix-core'
            

            def self.domain_to_mapper(pregnancy_status)
              mapper = self.new
              mapper.status_indicator = pregnancy_status.status_indicator
              mapper.expected_baby_quantity = pregnancy_status.expected_baby_quantity
              if pregnancy_status.status_valid_date_range
                mapper.status_valid_date_range = StatusValidDateRange.domain_to_mapper(pregnancy_status.status_valid_date_range)
              end
              mapper
            end

            def to_hash
              {
                status_indicator: status_indicator,
                status_valid_date_range: status_valid_date_range&.to_hash,
                expected_baby_quantity: expected_baby_quantity
              }
            end
          end
        end
      end
    end
  end
end