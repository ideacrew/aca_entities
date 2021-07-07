# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A data type for how to contact an organization.
          class ContactTelephoneNumber
            include HappyMapper

            tag 'ContactTelephoneNumber'
            namespace 'nc'

            # A postal address by which a person or organization may be contacted.
            has_one :telephone, FullTelephone, tag: 'FullTelephoneNumber'

            def self.domain_to_mapper(telephone_number)
              mapper = self.new
              mapper.telephone = FullTelephone.domain_to_mapper(telephone_number.telephone)
              mapper
            end

            def to_hash
              {
                telephone: telephone&.to_hash
              }
            end
          end
        end
      end
    end
  end
end