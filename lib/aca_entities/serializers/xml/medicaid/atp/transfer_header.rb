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

            def self.domain_to_mapper(transfer_header)
              mapper = self.new
              mapper.transfer_activity = TransferActivity.domain_to_mapper(transfer_header.transfer_activity)
              mapper
            end

            def to_hash
              {
                transfer_activity: transfer_activity&.to_hash
              }
            end
          end
        end
      end
    end
  end
end