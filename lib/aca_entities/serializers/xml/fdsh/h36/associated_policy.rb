# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an AssociatedPolicy.
          class AssociatedPolicy
            include HappyMapper

            tag 'AssociatedPolicy'

            element :QHPPolicyNum, String, tag: 'QHPPolicyNum'
            element :QHPIssuerEIN, String, tag: 'QHPIssuerEIN'
            element :SLCSPAdjMonthlyPremiumAmt, String, tag: 'SLCSPAdjMonthlyPremiumAmt'
            element :HouseholdAPTCAmt, String, tag: 'HouseholdAPTCAmt'
            element :TotalHsldMonthlyPremiumAmt, String, tag: 'TotalHsldMonthlyPremiumAmt'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.QHPPolicyNum = request.QHPPolicyNum
              mapper.QHPIssuerEIN = request.QHPIssuerEIN
              mapper.SLCSPAdjMonthlyPremiumAmt = format('%.2f', request.SLCSPAdjMonthlyPremiumAmt)
              mapper.HouseholdAPTCAmt = format('%.2f', request.HouseholdAPTCAmt)
              mapper.TotalHsldMonthlyPremiumAmt = format('%.2f', request.TotalHsldMonthlyPremiumAmt)

              mapper
            end
          end
        end
      end
    end
  end
end