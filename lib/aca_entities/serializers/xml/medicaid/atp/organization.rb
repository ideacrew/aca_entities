# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class Organization
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'Organization'
            namespace 'hix-core'

            has_one :organization_name, tag: 'OrganizationName'
            has_one :organization_primary_contact_information, ContactInformation, tag: 'OrganizationPrimaryContactInformation'

            def self.domain_to_mapper(organization)
              organization = self.new
              organization
            end
          end
        end
      end
    end
  end
end