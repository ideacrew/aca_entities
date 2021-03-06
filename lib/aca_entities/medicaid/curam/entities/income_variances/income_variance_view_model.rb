# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module IncomeVariances
        # IncomeVarianceViewModel
        class IncomeVarianceViewModel < Dry::Struct
          attribute :case_id, Types::String.meta(omittable: false)
          attribute :case_reference, Types::String.meta(omittable: false)
          attribute :case_kind, Types::String.meta(omittable: false)
          attribute :application_id, Types::String.meta(omittable: false)
          attribute :program_kind, Types::String.meta(omittable: false)
          attribute :aggregate_id, Types::String.meta(omittable: false)

          attribute :variance, Types.Instance(IncomeVarianceRecord).meta(omittable: false)
          attribute :incomes, Types::Array.of(Types.Instance(::Curam::ApplicationIncomes::ApplicationIncomeRecord))

          def matches_variance?(income)
            variance.application_income_aggregate_id == income.aggregate_id
          end
        end
      end
    end
  end
end