# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class IncomeFrequency
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'IncomeFrequency'
            namespace 'hix-core'

            element :frequency_code, String, tag: 'FrequencyCode', namespace: "hix-core"

            def self.domain_to_mapper(date_range)
              mapper = self.new
              mapper
            end

            def to_hash
              {
                frequency_code: frequency_code
              }
            end
          end
        end
      end
    end
  end
end