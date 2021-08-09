# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # xml mapping for Atp::IncomeFrequency
          class IncomeFrequency
            include HappyMapper

            tag 'IncomeFrequency'
            namespace 'hix-core'

            element :frequency_code, String, tag: 'FrequencyCode', namespace: "hix-core"

            def self.domain_to_mapper(income_frequency)
              mapper = self.new
              mapper.frequency_code = income_frequency.frequency_code
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