# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A data type for how to contact an organization.
          class ContactMailingAddress
            include HappyMapper

            tag 'ContactMailingAddress'
            namespace 'nc'

            # A postal address by which a person or organization may be contacted.
            has_one :address, StructuredAddress

            def self.domain_to_mapper(mailing_address)
              mapper = self.new
              mapper.address = StructuredAddress.domain_to_mapper(mailing_address.address)
              mapper
            end

            def to_hash
              {
                address: address&.to_hash
              }
            end
          end
        end
      end
    end
  end
end