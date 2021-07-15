# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # mapping xml Atp::LawfulPresenceStatusEligibility
          class LawfulPresenceStatusEligibility
            include HappyMapper

            tag 'LawfulPresenceStatusEligibility'
            namespace 'hix-ee'

            element :eligibility_indicator, Boolean, tag: 'EligibilityIndicator', namespace: "hix-ee"

            def self.domain_to_mapper(lawful_presence_status)
              mapper = self.new
              mapper.eligibility_indicator = lawful_presence_status.eligibility_indicator
              mapper
            end

            def to_hash
              {
                eligibility_indicator: eligibility_indicator,
                # eligibility_basis_status_code: eligibility_basis_status_code
              }
            end
          end
        end
      end
    end
  end
end