# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
<<<<<<< HEAD
          # An eligibility of a person to receive benefits under the Affordable Care Act. 
=======
          # mapping xml Atp::LawfulPresenceStatusEligibility
>>>>>>> refs/remotes/origin/happymapper_example_and_test
          class LawfulPresenceStatusEligibility
            include HappyMapper

            tag 'LawfulPresenceStatusEligibility'
            namespace 'hix-ee'

<<<<<<< HEAD
            element :eligibility_indicator, Boolean, tag: 'EligibilityIndicator', namespace: "hix-ee"
            element :eligibility_basis_status_code, String, tag: 'EligibilityBasisStatusCode', namespace: "hix-ee"
=======
            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "hix-core"
            element :eligibility_basis_status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "hix-ee"
>>>>>>> refs/remotes/origin/happymapper_example_and_test

            def self.domain_to_mapper(_medicaid_eligibility)
              self.new
            end

            def to_hash
              {
                eligibility_indicator: eligibility_indicator,
                eligibility_basis_status_code: eligibility_basis_status_code
              }
            end
          end
        end
      end
    end
  end
end