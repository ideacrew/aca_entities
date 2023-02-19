# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity IndividualExchange
      class IndividualExchange < Dry::Struct
        attribute :HealthExchangeId, AcaEntities::Types::String.meta(omittable: false)
        attribute :IrsHouseholdGroup, AcaEntities::Fdsh::H36::IrsHouseholdGroup.meta(omittable: false)
      end
    end
  end
end
