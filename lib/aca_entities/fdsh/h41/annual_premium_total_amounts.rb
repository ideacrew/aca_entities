# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 AnnaulPremiumTotalAmounts
      class AnnaulPremiumTotalAmounts
        attribute :AnnualPremiumAmt,  AcaEntities::Currency.meta(omittable: false)
        attribute :AnnualPremiumSLCSPAmt, AcaEntities::Currency.meta(omittable: false)
        attribute :AnnualAdvancedPTCAmt, AcaEntities::Currency.meta(omittable: false)
      end
    end
  end
end
