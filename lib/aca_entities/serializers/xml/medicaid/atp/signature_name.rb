# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A signature on a physical or electronic document.
          class SignatureName
            include HappyMapper

            tag 'SignatureName'
            namespace 'hix-core'

            element :given, String, tag: 'PersonGivenName', namespace: 'nc'
            element :middle, String, tag: 'PersonMiddleName', namespace: 'nc'
            element :sur, String, tag: 'PersonSurName', namespace: 'nc'
            element :suffix, String, tag: 'PersonNameSuffixText', namespace: 'nc'
            element :full, String, tag: 'PersonFullName', namespace: 'nc'

            def self.domain_to_mapper(signature_name)
              mapper = self.new
              mapper.given = signature_name.given
              mapper.middle = signature_name.middle
              mapper.sur = signature_name.sur
              mapper.suffix = signature_name.suffix
              mapper.full = signature_name.full
              mapper
            end

            def to_hash
              {
                given: given,
                middle: middle,
                sur: sur,
                suffix: suffix,
                full: full
              }
            end
          end
        end
      end
    end
  end
end