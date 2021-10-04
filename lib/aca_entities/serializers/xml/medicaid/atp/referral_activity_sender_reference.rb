# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class ReferralActivitySenderReference
            include HappyMapper

            tag 'ReferralActivitySenderReference'
            namespace 'hix-ee'

            attribute :ref, String, namespace: "niem-s"

            def self.domain_to_mapper(sender_reference)
              mapper = self.new
              mapper.ref = sender_reference&.ref
              mapper
            end

            def to_hash
              {
                ref: ref
              }
            end
          end
        end
      end
    end
  end
end