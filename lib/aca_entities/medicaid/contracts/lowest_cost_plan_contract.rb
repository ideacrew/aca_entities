# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for LowestCostPlan.
      class LowestCostPlanContract < Dry::Validation::Contract

        params do
          optional(:employer_lcsop_cost).maybe(:decimal)
          optional(:coverage_year_code).maybe(:string)
          optional(:employer_offers_mvsp).maybe(:bool)
          optional(:employee_do_not_know_mvsp).maybe(:bool)
        end
      end
    end
  end
end
