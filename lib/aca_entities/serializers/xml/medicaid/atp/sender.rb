# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class Sender
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'Sender'
            namespace 'hix-core'

            element :category_code, String, tag: "InformationExchangeSystemCategoryCode", namespace: 'hix-core'
            element :state_code, String, tag: "InformationExchangeSystemStateCode", namespace: 'hix-core'
            element :county_name, String, tag: "InformationExchangeSystemCountyName", namespace: 'hix-core'

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