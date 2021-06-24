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

            element :category_text, String, tag: 'OrganizationName', namespace: "nc"
            has_one :organization_primary_contact_information, OrganizationPrimaryContactInformation

            def self.domain_to_mapper(_expense)
              self.new
            end

            def to_hash
              {
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