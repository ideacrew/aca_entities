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

            has_many :immigration_documents, ImmigrationDocument

            # An eligibility of a person to receive benefits under the Affordable Care Act
            has_one :lawful_presence_status_eligibility, LawfulPresenceStatusEligibility

            # has_one :valid_date_range, StatusValidDateRange

            def self.domain_to_mapper(lawful_presence_status)
              mapper = self.new
              # mapper.valid_date_range = StatusValidDateRange.domain_to_mapper(lawful_presence_status.valid_date_range)
              if lawful_presence_status.immigration_documents && !lawful_presence_status.immigration_documents.nil
                mapper.immigration_documents = lawful_presence_status.immigration_documents.map { |imd| ImmigrationDocument.domain_to_mapper(imd) }
              end
              mapper.lawful_presence_status_eligibility =
                LawfulPresenceStatusEligibility.domain_to_mapper(lawful_presence_status.lawful_presence_status_eligibility)
              mapper
            end

            def to_hash
              {
                arrived_before_1996_indicator: arrived_before_1996_indicator,
                immigration_documents: immigration_documents&.to_hash,
                lawful_presence_status_eligibility: lawful_presence_status_eligibility&.to_hash
                # valid_date_range: valid_date_range.to_hash
              }
            end
          end
        end
      end
    end
  end
end