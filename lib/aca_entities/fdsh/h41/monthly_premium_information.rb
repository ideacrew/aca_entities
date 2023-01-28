# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 MonthlyPremiumInformation
      class MonthlyPremiumInformation
        attribute :MonthlyPremiumAmt,  AcaEntities::Currency.meta(omittable: false)
        attribute :MonthlyPremiumSLCSPAmt, AcaEntities::Currency.meta(omittable: false)
        attribute :MonthlyAdvancedPTCAmt, AcaEntities::Currency.meta(omittable: false)
      end
    end
  end
end
