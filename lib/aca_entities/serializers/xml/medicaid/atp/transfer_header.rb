# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class TransferHeader
            include HappyMapper
            register_namespace 'ext', 'http://at.dsh.cms.gov/extension/1.0'

            tag 'TransferHeader'
            namespace 'ext'

            element :transfer_activity, TransferActivity

            def self.domain_to_mapper(transfer_header)
              mapper = self.new
              mapper.transfer_activity = TransferActivity.domain_to_mapper(transfer_header)
              mapper
            end
          end
        end
      end
    end
  end
end