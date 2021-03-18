module Ehs
  module IncomeVariances
    class RecordIncomeVarianceCommand < Sequent::Command
      attrs application_income_aggregate_id: String
    end
  end
end