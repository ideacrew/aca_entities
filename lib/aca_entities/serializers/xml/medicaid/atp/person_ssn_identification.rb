# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class PersonSsnIdentification
            include HappyMapper

            tag 'PersonSSNIdentification'
            namespace 'nc'

            attribute :metadata, String, namespace: "niem-s"
            element :identification_id, String, tag: "IdentificationID"
            element :identification_category_text, String, tag: "IdentificationCategoryText"

            def self.domain_to_mapper(person, verification_metadata)
              ssn = person.ssn_identification
              mapper = self.new
              matching_ssa_response = mapper.fetch_ssa_response(person, verification_metadata)
              mapper.metadata = matching_ssa_response.id if matching_ssa_response
              mapper.identification_id = ssn&.identification_id if ssn&.identification_id
              mapper.identification_category_text = ssn.identification_category_text if ssn&.identification_category_text
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

            def to_hash
              {
                identification_id: identification_id
              }
            end
          end
        end
      end
    end
  end
end