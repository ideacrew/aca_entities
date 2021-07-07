# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class PersonName
            include HappyMapper

            tag 'PersonName'
            namespace 'nc'

            element :given, String, tag: "PersonGivenName", namespace: "nc"
            element :middle, String, tag: "PersonMiddleName", namespace: "nc"
            element :sur, String, tag: "PersonSurName", namespace: "nc"
            element :suffix, String, tag: 'PersonNameSuffixText', namespace: "nc"
            element :full, String, tag: 'PersonFullName', namespace: "nc"

            def self.domain_to_mapper(_person_name)
              self.new
            end

            def to_hash
              {
                given: given,
                middle: middle,
                sur: sur,
                suffix: suffix,
                full: [given, middle, sur].reject(&:nil?).join(' ')
              }
            end
          end
        end
      end
    end
  end
end