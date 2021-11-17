# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp ESI
      class Esi < Dry::Struct
        attribute :lowest_cost_plan, EsiLowestCostPlan.optional.meta(omittable: true)
        attribute :via_current_employee_indicator, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end