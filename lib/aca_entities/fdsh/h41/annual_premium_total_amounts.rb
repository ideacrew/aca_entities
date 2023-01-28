# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 AnnaulPremiumTotalAmounts
      class AnnualPremiumTotalAmounts < Dry::Struct
        attribute :AnnualPremiumAmt,  Types::Float.meta(omittable: false)
        attribute :AnnualPremiumSLCSPAmt, Types::Float.meta(omittable: false)
        attribute :AnnualAdvancedPTCAmt, Types::Float.meta(omittable: false)
      end
    end
  end
end
