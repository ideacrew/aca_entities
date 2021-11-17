# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An employer-sponsored insurance arrangement.
          class Esi
            include HappyMapper

            tag 'ESI'
            namespace 'hix-ee'

            has_one :lowest_cost_plan, EsiLowestCostPlan
            element :via_current_employee_indicator, Boolean, tag: 'ESIViaCurrentEmployeeIndicator', namespace: "hix-ee"

            def self.domain_to_mapper(esi)
              mapper = self.new
              mapper.lowest_cost_plan = EsiLowestCostPlan.domain_to_mapper(esi.lowest_cost_plan)
              mapper.via_current_employee_indicator = esi.via_current_employee_indicator
              mapper
            end

            def to_hash
              {
                lowest_cost_plan: lowest_cost_plan&.to_hash,
                via_current_employee_indicator: via_current_employee_indicator
              }
            end
          end
        end
      end
    end
  end
end