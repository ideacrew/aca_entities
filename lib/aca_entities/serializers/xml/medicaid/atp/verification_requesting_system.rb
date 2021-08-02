# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An information exchange system that requested a verification.
          class VerificationRequestingSystem
            include HappyMapper

            tag 'VerificationRequestingSystem'
            namespace 'hix-core'

            attribute :id, String, namespace: "niem-s"
            element :category_code, String, tag: "InformationExchangeSystemCategoryCode", namespace: 'hix-core'
            element :state_code, String, tag: "InformationExchangeSystemStateCode", namespace: 'hix-core'
            element :county_name, String, tag: "InformationExchangeSystemCountyName", namespace: 'hix-core'

            def self.domain_to_mapper(system)
              mapper = self.new
              mapper.id = system.id
              mapper.category_code = system.category_code
              mapper.state_code = system.state_code
              mapper.county_name = system.county_name
              mapper
            end

            def to_hash
              {
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