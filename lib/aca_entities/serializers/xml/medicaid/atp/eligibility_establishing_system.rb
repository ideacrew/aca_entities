# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A system making an eligibility determination.
          class EligibilityEstablishingSystem
            include HappyMapper

            tag 'EligibilityEstablishingSystem'
            namespace 'hix-ee'

            element :category_code, String, tag: "InformationExchangeSystemCategoryCode", namespace: "hix-core"
            element :state_code, String, tag: "InformationExchangeSystemStateCode", namespace: "hix-core"
            element :county_name, String, tag: "InformationExchangeSystemCountyName", namespace: "hix-core"

            def self.domain_to_mapper(ees)
              mapper = self.new
              mapper.category_code = ees.category_code
              mapper.state_code = ees.state_code
              mapper.county_name = ees.county_name
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