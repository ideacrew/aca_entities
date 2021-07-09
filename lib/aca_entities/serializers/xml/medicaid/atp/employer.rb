# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An outgoing monetary payment.
          class Employer
            include HappyMapper

            tag 'Employer'
            namespace 'hix-core'

            attribute :id, String, tag: 'id', namespace: 'nc'
            element :category_text, String, tag: 'OrganizationName', namespace: "nc"
            has_one :organization_primary_contact_information, OrganizationPrimaryContactInformation

            def self.domain_to_mapper(employer)
              mapper = self.new
              mapper.id = employer.id
              mapper.category_text = employer.category_text
              mapper.organization_primary_contact_information = OrganizationPrimaryContactInformation.domain_to_mapper(employer.organization_primary_contact_information)
              mapper
            end

            def to_hash
              {
                employer_id: id,
                category_text: category_text,
                organization_primary_contact_information: organization_primary_contact_information&.to_hash
              }
            end
          end
        end
      end
    end
  end
end