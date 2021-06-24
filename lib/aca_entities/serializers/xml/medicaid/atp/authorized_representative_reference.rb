# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class AuthorizedRepresentativeReference
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'niem-s', 'http://niem.gov/niem/structures/2.0'

            tag 'AuthorizedRepresentativeReference'
            namespace 'hix-ee'

            attribute :ref, String, namespace: "niem-s"

            def self.domain_to_mapper(_rep)
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