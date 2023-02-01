# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class MonthlyPremiumInformation
            include HappyMapper
            register_namespace 'airty20a', 'urn:us:gov:treasury:irs:ext:aca:air:ty20a'

            namespace 'airty20a'

            element :MonthlyPremiumAmt, String, tag: 'MonthlyPremiumAmt'
            element :MonthlyPremiumSLCSPAmt, String, tag: 'MonthlyPremiumSLCSPAmt'
            element :MonthlyAdvancedPTCAmt, String, tag: 'MonthlyAdvancedPTCAmt'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.MonthlyPremiumAmt = format('%.2f', request.MonthlyPremiumAmt)
              mapper.MonthlyPremiumSLCSPAmt = format('%.2f', request.MonthlyPremiumSLCSPAmt)
              mapper.MonthlyAdvancedPTCAmt = format('%.2f', request.MonthlyAdvancedPTCAmt)

              mapper
            end
          end
        end
      end
    end
  end
end
