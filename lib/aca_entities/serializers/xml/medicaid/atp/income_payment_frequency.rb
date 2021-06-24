# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # xml mapping for Atp::IncomePaymentFrequency
          class IncomePaymentFrequency
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'IncomePaymentFrequency'
            namespace 'hix-core'

            element :frequency_code, String, tag: 'FrequencyCode', namespace: "hix-core"

            def self.domain_to_mapper(_date_range)
              self.new
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