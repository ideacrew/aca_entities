# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # element: A entity that starts the referral process.
          # type: A data type for An entity that started the referral process.
          class TransferHeader
            include HappyMapper

            tag 'TransferHeader'
            namespace 'ext'

            has_one :transfer_activity, TransferActivity
            element :recipient_state_code, String, tag: 'RecipientTransferActivityStateCode', namespace: 'ext'

            def self.domain_to_mapper(transfer_header)
              mapper = self.new
              mapper.transfer_activity = TransferActivity.domain_to_mapper(transfer_header.transfer_activity)
              mapper.recipient_state_code = transfer_header.recipient_state_code
              mapper
            end

            def to_hash
              {
                transfer_activity: transfer_activity&.to_hash,
                recipient_state_code: recipient_state_code
              }
            end
          end
        end
      end
    end
  end
end