# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp ESI LowestCostPLan
      class EsiLowestCostPlan < Dry::Struct
        attribute :minimum_avs_indicator, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end