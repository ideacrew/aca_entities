# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A system making an eligibility determination.
          class EligibilityEstablishingSystem
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'EligibilityEstablishingSystem'
            namespace 'hix-ee'

            element :category_code, String, tag: "InformationExchangeSystemCategoryCode", namespace: "hix-core"
            element :state_code, String, tag: "InformationExchangeSystemStateCode", namespace: "hix-core"
            element :county_name, String, tag: "InformationExchangeSystemCountyName", namespace: "hix-core"

            def self.domain_to_mapper(_date_range)
              self.new
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