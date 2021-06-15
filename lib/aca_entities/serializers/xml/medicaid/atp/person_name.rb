# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class PersonName
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'PersonName'
            namespace 'nc'

            element :given, String, tag: "PersonGivenName", namespace: "nc"
            element :middle, String, tag: "PersonMiddleName", namespace: "nc"
            element :sur, String, tag: "PersonSurName", namespace: "nc"
            element :suffix, String, tag: 'PersonNameSuffixText', namespace: "nc"
            element :full, String, tag: 'PersonFullName', namespace: "nc"

            def self.domain_to_mapper(_person)
              self.new
            end
          end
        end
      end
    end
  end
end