# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class Receiver
            include HappyMapper

            tag 'Receiver'
            namespace 'hix-core'

            # A kind of system that participates in the exchange of electronic information.
            element :category_code, String, tag: "InformationExchangeSystemCategoryCode", namespace: "hix-core"

            def self.domain_to_mapper(_account_transfer_request)
              self.new
            end

            def to_hash
              {
                category_code: category_code
              }
            end
          end
        end
      end
    end
  end
end