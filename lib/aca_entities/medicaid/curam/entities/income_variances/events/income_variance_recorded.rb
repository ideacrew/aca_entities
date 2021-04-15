# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module IncomeVariances
        module Events
          # IncomeVarianceRecorded event
          class IncomeVarianceRecorded < Sequent::Event
            attrs application_income_aggregate_id: String
          end
        end
      end
    end
  end
end