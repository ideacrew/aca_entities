# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class PersonReference
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'niem-s', 'http://niem.gov/niem/structures/2.0'

            tag 'PersonReference'
            namespace 'hix-core'

            attribute :ref, String, namespace: "niem-s"

            def self.domain_to_mapper(person)
              mapper = self.new
              mapper.ref = "a-person-id"
              mapper
            end
          end
        end
      end
    end
  end
end