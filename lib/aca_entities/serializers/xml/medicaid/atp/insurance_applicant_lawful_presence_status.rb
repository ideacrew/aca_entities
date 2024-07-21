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

            attribute :metadata, String, namespace: "niem-s"
            # True if a person arrived in the US before 1996; false otherwise.
            element :arrived_before_1996_indicator, Boolean, tag: 'LawfulPresenceStatusArrivedBefore1996Indicator'

            has_many :immigration_documents, ImmigrationDocument

            # An eligibility of a person to receive benefits under the Affordable Care Act
            has_one :lawful_presence_status_eligibility, LawfulPresenceStatusEligibility

            # has_one :valid_date_range, StatusValidDateRange

            def self.domain_to_mapper(insurance_applicant, verification_metadata)
              mapper = self.new
              matching_vlp_response = mapper.fetch_vlp_response(insurance_applicant, verification_metadata)
              mapper.metadata = matching_vlp_response.id if matching_vlp_response.present?
              lawful_presence_status = insurance_applicant.lawful_presence_status
              if lawful_presence_status&.immigration_documents && !lawful_presence_status&.immigration_documents.nil?
                mapper.immigration_documents = lawful_presence_status.immigration_documents.map { |imd| ImmigrationDocument.domain_to_mapper(imd) }
              end
              mapper.lawful_presence_status_eligibility =
                LawfulPresenceStatusEligibility.domain_to_mapper(lawful_presence_status&.lawful_presence_status_eligibility)
              mapper
            end

            def fetch_vlp_response(insurance_applicant, verification_metadata)
              return nil unless verification_metadata

              vlp_responses = verification_metadata.select {|meta_data| meta_data.id.match(/vmdhs/)}
              vlp_responses.detect do |data|
                person_id = insurance_applicant.role_reference&.ref&.scan(/\d+/)&.first
                data_id = data.id&.scan(/\d+/)&.first

                person_id == data_id
              end
            end

            def to_hash
              {
                arrived_before_1996_indicator: arrived_before_1996_indicator,
                immigration_documents: immigration_documents.map(&:to_hash),
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