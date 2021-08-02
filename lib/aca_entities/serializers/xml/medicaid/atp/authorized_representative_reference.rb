# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class AuthorizedRepresentativeReference
            include HappyMapper

            tag 'AuthorizedRepresentativeReference'
            namespace 'hix-ee'

            attribute :ref, String, namespace: "niem-s"

            def self.domain_to_mapper(authorized_rep_ref)
              mapper = self.new
              mapper.ref = authorized_rep_ref.ref
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