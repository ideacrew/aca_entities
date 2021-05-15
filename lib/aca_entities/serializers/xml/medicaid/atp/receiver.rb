# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class Receiver
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'Receiver'
            namespace 'hix-core'

            def self.domain_to_mapper(account_transfer_request)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end