# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class Organization
            include HappyMapper

            tag 'Organization'
            namespace 'hix-core'

            has_one :organization_name, tag: 'OrganizationName'
            has_one :organization_primary_contact_information, OrganizationPrimaryContactInformation

            def self.domain_to_mapper(organization)
              mapper = self.new
              mapper.organization_name = organization.organization_name
              mapper.organization_primary_contact_information = organization.organization_primary_contact_information
              mapper
            end

            def to_hash
              {
                organization_name: organization_name,
                organization_primary_contact_information: organization_primary_contact_information&.to_hash
              }
            end
          end
        end
      end
    end
  end
end