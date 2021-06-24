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

            element :signature, DateTime, tag: 'SignatureDate', namespace: 'hix-core'

            def self.domain_to_mapper(signature)
              self.new
            end
          end
        end
      end
    end
  end
end