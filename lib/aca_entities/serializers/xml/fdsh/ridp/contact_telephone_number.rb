# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # ContactTelephoneNumber.
          class ContactTelephoneNumber
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'ContactTelephoneNumber'
            namespace 'nc'

            element :FullTelephoneNumber, String, tag: 'FullTelephoneNumber'

            def self.domain_to_mapper(contact_telephone_number)
              mapper = self.new
              mapper.FullTelephoneNumber = contact_telephone_number.FullTelephoneNumber
              mapper
            end
          end
        end
      end
    end
  end
end
