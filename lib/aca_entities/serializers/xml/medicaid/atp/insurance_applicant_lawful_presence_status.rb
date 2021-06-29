# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A status of the applicant's lawful presence in the United States.
          class InsuranceApplicantLawfulPresenceStatus
            include HappyMapper

            tag 'InsuranceApplicantLawfulPresenceStatus'
            namespace 'hix-ee'

            # True if a person arrived in the US before 1996; false otherwise.
            element :arrived_before_1996_indicator, Boolean, tag: 'LawfulPresenceStatusArrivedBefore1996Indicator'

<<<<<<< HEAD
            # An eligibility of a person to receive benefits under the Affordable Care Act
            has_one :eligibility, LawfulPresenceStatusEligibility
=======
            #An eligibility of a person to receive benefits under the Affordable Care Act
            has_one :lawful_presence_status_eligibility, LawfulPresenceStatusEligibility
>>>>>>> Added class defs and contracts in medicaid/atp that map to ACE person fields

            def self.domain_to_mapper(_presence_status)
              self.new
            end

            def to_hash
              {
                arrived_before_1996_indicator: arrived_before_1996_indicator,
                eligibility: eligibility.to_hash
              }
            end
          end
        end
      end
    end
  end
end