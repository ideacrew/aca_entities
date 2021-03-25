# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module IncomeVariances
        # RecordIncomeVarianceCommand
        class RecordIncomeVarianceCommand < Sequent::Command
          attrs application_income_aggregate_id: String
        end
      end
    end
  end
end