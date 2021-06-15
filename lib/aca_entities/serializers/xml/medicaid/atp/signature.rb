# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A signature on a physical or electronic document.
          class Signature
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'Signature'
            namespace 'hix-ee'

            element :signature, Date, tag: 'SignatureDate', namespace: 'hix-core'

            def self.domain_to_mapper(signature)
              self.new
            end
          end
        end
      end
    end
  end
end