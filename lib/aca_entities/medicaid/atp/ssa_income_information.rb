# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for SsaIncomeInformation.
      class SsaIncomeInformation < Dry::Struct

        attribute :annual_title_ii_income,   Types::Float.optional.meta(omittable: true)
        attribute :monthly_title_ii_income,  Types::Float.optional.meta(omittable: true)
        # The month for which the SSA reported income amount applies.
        attribute :title_ii_income_month,    Types::Date.optional.meta(omittable: true)
        # The year for which the SSA report income amount applies.
        attribute :title_ii_income_year,     Types::Date.optional.meta(omittable: true)
      end
    end
  end
end
