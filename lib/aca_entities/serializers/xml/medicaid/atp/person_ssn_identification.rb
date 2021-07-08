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

            element :identification_id, String, tag: "IdentificationID"

            def self.domain_to_mapper(ssn)
              mapper = self.new
              mapper.identification_id = ssn.identification_id
              mapper
            end

            def to_hash
              {
                ref: ref
              }
            end
          end
        end
      end
    end
  end
end