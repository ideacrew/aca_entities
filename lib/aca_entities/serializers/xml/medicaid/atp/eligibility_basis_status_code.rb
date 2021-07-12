# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A status of an eligibility basis determination.
          class EligibilityBasisStatusCode
            include HappyMapper

            tag 'EligibilityBasisStatusCode'
            namespace 'hix-ee'

            def self.domain_to_mapper(_medicaid_eligibility)
              self.new
            end
          end
        end
      end
    end
  end
end