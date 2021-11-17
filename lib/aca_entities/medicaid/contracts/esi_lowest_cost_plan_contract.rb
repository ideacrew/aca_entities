# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for Esi
      class EsiLowestCostPlanContract < Dry::Validation::Contract

        params do
          optional(:minimum_avs_indicator).maybe(:bool)
        end
      end
    end
  end
end
