# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class PersonReference
            include HappyMapper

            tag 'PersonReference'
            namespace 'hix-core'

            attribute :ref, String, namespace: "niem-s"

            def self.domain_to_mapper(person)
              mapper = self.new
              mapper.ref = "a-person-id"
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