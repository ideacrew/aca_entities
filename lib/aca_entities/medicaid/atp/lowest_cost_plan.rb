# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for LowestCostPlan.
      class LowestCostPlan < Dry::Struct
        attribute :employer_lcsop_cost,    Types::Float.optional.meta(omittable: true)
        attribute :coverage_year_code,     Types::String.optional.meta(omittable: true)

        # Employer Offers Minimum Value Standard Plan.
        attribute :employer_offers_mvsp,   Types::Bool.optional.meta(omittable: true)
        attribute :employee_do_not_know_mvsp, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
