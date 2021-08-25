# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A postal address by which a person or organization may be contacted.
          class ContactMailingAddress
            include HappyMapper

            tag 'ContactMailingAddress'
            namespace 'nc'

            # A postal address by which a person or organization may be contacted.
            has_one :address, StructuredAddress

            def self.domain_to_mapper(mailing_address)
              mapper = self.new
              mapper.address = StructuredAddress.domain_to_mapper(mailing_address.address) if mailing_address
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