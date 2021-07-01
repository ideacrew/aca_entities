# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # element: An information exchange system sending information.
          # type: A data type for a system that participates in the exchange of
          #       electronic information (such as a Medicaid system, the
          #       Federally Facilitated Exchange, an issuer system, a Social
          #       Security Administration system, etc.).
          class Sender
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'Sender'
            namespace 'hix-core'

            element :category_code, String, tag: "InformationExchangeSystemCategoryCode", namespace: 'hix-core'
            element :state_code, String, tag: "InformationExchangeSystemStateCode", namespace: 'hix-core'
            element :county_name, String, tag: "InformationExchangeSystemCountyName", namespace: 'hix-core'

            def self.domain_to_mapper(_account_transfer_request)
              self.new
            end
          end
        end
      end
    end
  end
end