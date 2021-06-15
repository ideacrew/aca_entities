# frozen_string_literal: true
module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # 
          class LawfulPresenceStatusEligibility
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'LawfulPresenceStatusEligibility'
            namespace 'hix-ee'

            has_one :status_indicator, StatusIndicator
            has_one :eligibility_basis_status_code, EligibilityBasisStatusCode

            def self.domain_to_mapper(medicaid_eligibility)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end