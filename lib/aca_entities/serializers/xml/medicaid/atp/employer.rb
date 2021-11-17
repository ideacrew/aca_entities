# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Employer details
          class Employer
            include HappyMapper

            tag 'Employer'
            namespace 'hix-core'

            attribute :id, String, namespace: "niem-s"
            element :category_text, String, tag: 'OrganizationName', namespace: "nc"
            has_one :organization_primary_contact_information, OrganizationPrimaryContactInformation
            has_one :organization_augmentation, OrganizationAugmentation

            def self.domain_to_mapper(employer)
              mapper = self.new
              mapper.id = employer.id if employer.id && !employer.id.empty?
              mapper.category_text = employer.category_text
              mapper.organization_primary_contact_information =
                OrganizationPrimaryContactInformation.domain_to_mapper(employer.organization_primary_contact_information)
              if employer.organization_augmentation
                mapper.organization_augmentation = OrganizationAugmentation.domain_to_mapper(employer.organization_augmentation)
              end
              mapper
            end

            def to_hash
              {
                id: id,
                category_text: category_text,
                organization_primary_contact_information: organization_primary_contact_information&.to_hash,
                organization_augmentation: organization_augmentation&.to_hash
              }
            end
          end
        end
      end
    end
  end
end