# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A verification supplement provided by the Department of Homeland Security (DHS)
          # Systematic Alien Verification for Entitlements (SAVE) program.
          class PersonUsCitizenIndicator
            include HappyMapper

            attribute :metadata, String, namespace: "niem-s"
            tag 'PersonUSCitizenIndicator'
            namespace 'nc'

            # A step in the Department of Homeland Security (DHS) Systematic Alien Verification for Entitlements (SAVE) process.
            content :value, Boolean

            def self.domain_to_mapper(person, verification_metadata)
              us_citizen_indicator = person&.us_citizen_indicator
              mapper = self.new
              matching_ssa_response = mapper.fetch_ssa_response(person, verification_metadata)
              mapper.metadata = matching_ssa_response&.id if matching_ssa_response&.verification_category_codes&.include?("Citizenship")
              mapper.value = us_citizen_indicator
              mapper
            end

            def fetch_ssa_response(person, verification_metadata)
              return nil unless verification_metadata

              ssa_responses = verification_metadata.select {|meta_data| meta_data.id.match(/vmssa/)}
              ssa_responses.detect do |data|
                person_id = person.id&.scan(/\d+/)&.first
                data_id = data.id&.scan(/\d+/)&.first

                person_id == data_id
              end
            end
          end
        end
      end
    end
  end
end
