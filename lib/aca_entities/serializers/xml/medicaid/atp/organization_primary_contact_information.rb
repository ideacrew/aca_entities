# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A data type for how to contact an organization.
          class OrganizationPrimaryContactInformation
            include HappyMapper

            tag 'OrganizationPrimaryContactInformation'
            namespace 'nc'

            # An electronic mailing address by which a person or organization may be contacted.
            element :email_id, String, tag: "ContactEmailID", namespace: "nc"

            # A postal address by which a person or organization may be contacted.
            has_one :mailing_address, ContactMailingAddress

            # A telephone number for a telecommunication device by which a person or organization may be contacted.
            has_one :telephone_number, ContactTelephoneNumber

            def self.domain_to_mapper(contact_info)
              mapper = self.new
              mapper.email_id = contact_info&.email_id
              mapper.mailing_address = ContactMailingAddress.domain_to_mapper(contact_info&.mailing_address) if contact_info&.mailing_address
              mapper.telephone_number = ContactTelephoneNumber.domain_to_mapper(contact_info&.telephone_number) if contact_info&.telephone_number
              mapper
            end

            def to_hash
              {
                email_id: email_id,
                mailing_address: mailing_address&.to_hash,
                telephone_number: telephone_number&.to_hash
              }
            end
          end
        end
      end
    end
  end
end