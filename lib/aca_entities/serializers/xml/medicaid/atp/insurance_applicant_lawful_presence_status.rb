# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A status of the applicant's lawful presence in the United States.
          class InsuranceApplicantLawfulPresenceStatus
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'InsuranceApplicantLawfulPresenceStatus'
            namespace 'hix-ee'

            #True if a person arrived in the US before 1996; false otherwise.
            element :arrived_before_1996_indicator, Boolean, tag: 'LawfulPresenceStatusArrivedBefore1996Indicator'

            #An eligibility of a person to receive benefits under the Affordable Care Act
            has_one :eligibility, LawfulPresenceStatusEligibility

            def self.domain_to_mapper(presence_status)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end