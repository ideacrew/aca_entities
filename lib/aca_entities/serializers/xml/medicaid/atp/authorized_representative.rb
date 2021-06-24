# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An authorized representative who is granted limited power of attorney for an insurance application.
          class AuthorizedRepresentative
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'ns1', "http://niem.gov/niem/structures/2.0"

            tag 'AuthorizedRepresentative'
            namespace 'hix-ee'

            attribute :id, String, namespace: "ns1"

            has_one :role_played_by_person, RolePlayedByPerson

            def self.domain_to_mapper(_representative)
              self.new
            end
          end
        end
      end
    end
  end
end