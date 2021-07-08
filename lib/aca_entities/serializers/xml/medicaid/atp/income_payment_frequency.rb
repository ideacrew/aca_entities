# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # xml mapping for Atp::IncomePaymentFrequency
          class IncomePaymentFrequency
            include HappyMapper

            tag 'IncomePaymentFrequency'
            namespace 'hix-core'

            element :frequency_code, String, tag: 'FrequencyCode', namespace: "hix-core"

            def self.domain_to_mapper(pf)
              mapper = self.new
              mapper.frequency_code = pf.frequency_code
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