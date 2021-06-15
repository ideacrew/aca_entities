# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class HouseholdMemberReference
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'niem-s', 'http://niem.gov/niem/structures/2.0'

            tag 'HouseholdMemberReference'
            namespace 'hix-ee'

            attribute :ref, String, namespace: "niem-s"

            def self.domain_to_mapper(_insurance_application)
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