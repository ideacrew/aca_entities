module Ehs
  module IncomeVariances
    module Events
      class IncomeVarianceRecorded < Sequent::Event
        attrs application_income_aggregate_id: String
      end
    end
  end
end