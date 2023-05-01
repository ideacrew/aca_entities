# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module PayNow
        module CareFirst
          # Happymapper implementation for the root object of a PaynowTransferPayloadType.
          class PayNowTransferPayload
            include HappyMapper

            tag 'PayNowTransferPayload'

            element :coverage_kind, String, tag: 'coverage_kind'
            has_one :primary, Primary
            has_many :members, Member

            def self.domain_to_mapper(pay_now_transfer_payload)
              mapper = self.new
              mapper.coverage_kind = pay_now_transfer_payload.coverage_kind
              mapper.primary = Primary.domain_to_mapper(pay_now_transfer_payload.primary)
              mapper.members = Members.domain_to_mapper(pay_now_transfer_payload.members)
              mapper
            end
          end
        end
      end
    end
  end
end