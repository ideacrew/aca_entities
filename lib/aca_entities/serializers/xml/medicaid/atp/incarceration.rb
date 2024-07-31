# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A description of the applicant's incarceration history.
          class Incarceration
            include HappyMapper

            tag 'InsuranceApplicantIncarceration'
            namespace 'hix-ee'

            attribute :metadata, String, namespace: "niem-s"

            # True if the person is incarcerated; false otherwise.
            has_one :incarceration_date, IncarcerationDate

            # True if the person is incarcerated; false otherwise.
            element :incarceration_indicator, Boolean, tag: 'IncarcerationIndicator', namespace: 'hix-core'

            def self.domain_to_mapper(insurance_applicant, inc, verification_metadata)
              mapper = self.new
              matching_ssa_response = mapper.fetch_ssa_response(insurance_applicant, verification_metadata)
              mapper.metadata = matching_ssa_response&.id if matching_ssa_response&.verification_category_codes&.include?("IncarcerationStatus")
              mapper.incarceration_date = IncarcerationDate.domain_to_mapper(inc.incarceration_date) if inc.incarceration_date
              mapper.incarceration_indicator = inc.incarceration_indicator
              mapper
            end

            def fetch_ssa_response(insurance_applicant, verification_metadata)
              return nil unless verification_metadata

              ssa_responses = verification_metadata.select {|meta_data| meta_data.id.match(/vmssa/)}
              ssa_responses.detect do |data|
                person_id = insurance_applicant.role_reference&.ref&.scan(/\d+/)&.first
                data_id = data.id&.scan(/\d+/)&.first

                person_id == data_id
              end
            end

            def to_hash
              {
                incarceration_indicator: incarceration_indicator,
                incarceration_date: incarceration_date&.to_hash
              }
            end
          end
        end
      end
    end
  end
end