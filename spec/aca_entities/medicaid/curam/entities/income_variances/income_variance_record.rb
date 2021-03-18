module Ehs
  module IncomeVariances
    class IncomeVarianceRecord < Sequent::ApplicationRecord
      belongs_to :application_income_record,
               foreign_key: "application_income_aggregate_id",
               primary_key: "aggregate_id",
               class_name: "::Ehs::ApplicationIncomes::ApplicationIncomeRecord",
               required: false

      def unresolved?
        status == "unresolved"
      end
    end
  end
end