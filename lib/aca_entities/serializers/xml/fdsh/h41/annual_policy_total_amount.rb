# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class AnnualPolicyTotalAmount
            include HappyMapper
            register_namespace 'airty20a', 'urn:us:gov:treasury:irs:ext:aca:air:ty20a'

            namespace 'airty20a'

            element :AnnualPremiumAmt, String, tag: 'AnnualPremiumAmt'
            element :AnnualPremiumSLCSPAmt, String, tag: 'AnnualPremiumSLCSPAmt'
            element :AnnualAdvancedPTCAmt, String, tag: 'AnnualAdvancedPTCAmt'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.AnnualPremiumAmt = format('%.2f', request.AnnualPremiumAmt)
              mapper.AnnualPremiumSLCSPAmt = format('%.2f', request.AnnualPremiumSLCSPAmt)
              mapper.AnnualAdvancedPTCAmt = format('%.2f', request.AnnualAdvancedPTCAmt)

              mapper
            end
          end
        end
      end
    end
  end
end
