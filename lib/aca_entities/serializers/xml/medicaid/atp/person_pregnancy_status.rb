# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # 
          class PersonPregnancyStatus
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'PersonPregnancyStatus'
            namespace 'hix-core'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "ns3"
            has_one :status_valid_date_range, StatusValidDateRange
            element :expected_baby_quantity, Integer, tag: 'PregnancyStatusExpectedBabyQuantity', namespace:'hix-core'

            def self.domain_to_mapper(person)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end