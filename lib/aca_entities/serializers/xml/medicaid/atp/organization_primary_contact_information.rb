# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A data type for how to contact an organization.
          class OrganizationPrimaryContactInformation
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'OrganizationPrimaryContactInformation'
            namespace 'nc'

            #An electronic mailing address by which a person or organization may be contacted.
            element :email_id, String, tag: 'ContactEmailID'

            #A postal address by which a person or organization may be contacted.
            has_one :mailing_address, StructuredAddress, tag: 'ContactMailingAddress'

            #A telephone number for a telecommunication device by which a person or organization may be contacted.
            has_one :telephone_number, FullTelephone, tag: 'ContactTelephoneNumber'

            def self.domain_to_mapper(contact_info)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end