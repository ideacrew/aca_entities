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
            register_namespace 'ex', 'http://ridp.dsh.cms.gov/exchange/1.0'
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'


            tag 'ContactInformation'
            namespace 'ext'

            has_one :FullTelephoneNumber, namespace: 'nc:ContactTelephoneNumber', tag: 'FullTelephoneNumber'

            def self.domain_to_mapper(contact_information)
              mapper = self.new
              mapper.FullTelephoneNumber = ResponseMetadata.domain_to_mapper(contact_information.FullTelephoneNumber)
              mapper
            end
          end
        end
      end
    end
  end
end