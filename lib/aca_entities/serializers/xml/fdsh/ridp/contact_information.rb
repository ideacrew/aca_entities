# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # ContactInformation.
          class ContactInformation
            include HappyMapper
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'

            tag 'ContactInformation'
            namespace 'ext'

            has_one :ContactTelephoneNumber, ContactTelephoneNumber

            def self.domain_to_mapper(contact_information)
              mapper = self.new
              if contact_information&.ContactTelephoneNumber
                mapper.ContactTelephoneNumber = ContactTelephoneNumber.domain_to_mapper(contact_information&.ContactTelephoneNumber)
              end
              mapper
            end
          end
        end
      end
    end
  end
end
