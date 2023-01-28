# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 Policy
      class Policy
        attribute :MarketPlacePolicyNum,  AcaEntities::Types::String.meta(omittable: false)
        attribute :PolicyIssuerNm,  AcaEntities::Types::String.meta(omittable: false)
        attribute :PolicyStartDt,  AcaEntities::Types::Date.meta(omittable: false)
        attribute :PolicyTerminationDt, AcaEntities::Types::Date.optional.meta(omittable: true)
      end
    end
  end
end
