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

            # A human being.
            has_one :role_played_by_person, RolePlayedByPerson

            def self.domain_to_mapper(authorized_representative)
              mapper = self.new
              mapper.id = authorized_representative.id
              mapper.role_played_by_person = authorized_representative.role_played_by_person
              mapper
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