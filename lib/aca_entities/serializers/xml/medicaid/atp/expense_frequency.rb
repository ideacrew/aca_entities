# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class ExpenseFrequency
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'ExpenseFrequency'
            namespace 'hix-core'

            has_one :frequency_code, String, tag: 'FrequencyCode', namespace: "hix-core"

            def self.domain_to_mapper(date_range)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end