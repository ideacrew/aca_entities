# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A signature on a physical or electronic document.
          class Signature
            include HappyMapper

            tag 'Signature'
            namespace 'hix-ee'

            element :signature_name, SignatureName, tage: 'SignatureName', namespace: 'hix-core'
            element :signature_date, SignatureDate, tag: 'SignatureDate', namespace: 'hix-core'

            def self.domain_to_mapper(signature)
              mapper = self.new
              if signature.signature_name && !signature.signature_name.nil?
                mapper.signature_name = SignatureName.domain_to_mapper(signature.signature_name)
              end
              mapper.signature_date = SignatureDate.domain_to_mapper(signature.signature_date)
              mapper
            end

            def to_hash
              {
                signature_name: signature_name&.to_hash,
                signature_date: signature_date&.to_hash
              }
            end
          end
        end
      end
    end
  end
end