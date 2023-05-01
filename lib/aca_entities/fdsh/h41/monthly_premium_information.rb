# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 MonthlyPremiumInformation
      class MonthlyPremiumInformation < Dry::Struct
        attribute :MonthlyPremiumAmt,  Types::Float.meta(omittable: false)
        attribute :MonthlyPremiumSLCSPAmt, Types::Float.meta(omittable: false)
        attribute :MonthlyAdvancedPTCAmt, Types::Float.meta(omittable: false)
      end
    end
  end
end
