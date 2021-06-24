# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An authorized representative who is granted limited power of attorney for an insurance application.
          class AuthorizedRepresentative
            include HappyMapper

            tag 'AuthorizedRepresentative'
            namespace 'hix-ee'

            attribute :id, String, namespace: "niem-s"

            has_one :role_played_by_person, RolePlayedByPerson

            def self.domain_to_mapper(_representative)
              self.new
            end

            def to_hash
              {
                role_played_by_person: role_played_by_person&.to_hash
              }
            end
          end
        end
      end
    end
  end
end