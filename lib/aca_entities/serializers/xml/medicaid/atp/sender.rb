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

            tag 'Sender'
            namespace 'hix-core'

            attribute :id, String, namespace: "niem-s"
            element :category_code, String, tag: "InformationExchangeSystemCategoryCode", namespace: 'hix-core'
            element :state_code, String, tag: "InformationExchangeSystemStateCode", namespace: 'hix-core'
            element :county_name, String, tag: "InformationExchangeSystemCountyName", namespace: 'hix-core'

            def self.domain_to_mapper(sender)
              mapper = self.new
              mapper.id = sender.id
              mapper.category_code = sender.category_code
              mapper.state_code = sender.state_code
              mapper.county_name = sender.county_name
              mapper
            end

            def to_hash
              {
                id: id,
                category_code: category_code,
                state_code: state_code,
                county_name: county_name
              }
            end
          end
        end
      end
    end
  end
end