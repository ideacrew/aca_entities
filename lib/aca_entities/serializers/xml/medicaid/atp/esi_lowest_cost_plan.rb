# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An employer sponsored insurance (ESI) plan that is the lowest-cost self-only plan that meets the minimum value standard.
          class EsiLowestCostPlan
            include HappyMapper

            tag 'ESILowestCostPlan'
            namespace 'hix-pm'

            element :minimum_avs_indicator, Boolean, tag: 'MinimumActuarialValueStandardIndicator', namespace: "hix-pm"

            def self.domain_to_mapper(plan)
              mapper = self.new
              mapper.minimum_avs_indicator = plan.minimum_avs_indicator
              mapper
            end

            def to_hash
              {
                minimum_avs_indicator: minimum_avs_indicator
              }
            end
          end
        end
      end
    end
  end
end