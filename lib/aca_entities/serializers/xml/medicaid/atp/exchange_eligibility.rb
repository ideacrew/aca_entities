# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An assessment of a person's suitability to participate in an exchange eligibility program
          class ExchangeEligibility
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'ExchangeEligibility'
            namespace 'hix-ee'

            has_one :eligibility_date_range, EligibilityDateRange

            has_one :eligibility_establishing_system, EligibilityEstablishingSystem

            def self.domain_to_mapper(eligibility)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end