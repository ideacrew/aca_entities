# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class Signature
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'Signature'
            namespace 'hix-ee'

            element :signature_name, String, tag: 'SignatureName', namespace: 'hix-core'
            element :signature_date, Date, tag: 'SignatureDate', namespace: 'hix-core'

            def self.domain_to_mapper(insurance_application)
              mapper = self.new
              mapper.signature_date = insurance_application.application_metadata.original_signature_date
              mapper
            end

          end
        end
      end
    end
  end
end
