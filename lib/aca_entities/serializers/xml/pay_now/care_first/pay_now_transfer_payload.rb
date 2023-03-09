# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module PayNow
        module CareFirst
          # Happymapper implementation for the root object of a PaynowTransferPayloadType.
          class PayNowTransferPayload
            include HappyMapper

            tag 'saml:AttributeValue'
            register_namespace 'xmlns', 'http://openhbx.org/api/terms/1.0'
            register_namespace 'cv', 'http://openhbx.org/api/terms/1.0'
            register_namespace 'xsi', 'http://www.w3.org/2001/XMLSchema-instance'

            attribute :type, String, tag: 'type', namespace: 'xsi'

            element :coverage_kind, String, tag: 'coverage_kind'
            has_one :primary, Primary
            has_many :members, Member

            def self.domain_to_mapper(pay_now_transfer_payload)
              mapper = self.new
              mapper.type = 'cv:PaynowTransferPayloadType'
              mapper.coverage_kind = pay_now_transfer_payload.coverage_kind
              mapper.primary = pay_now_transfer_payload.primary
              mapper.members = pay_now_transfer_payload.members.map {|m| Member.domain_to_mapper(m)}
              mapper
            end
          end
        end
      end
    end
  end
end