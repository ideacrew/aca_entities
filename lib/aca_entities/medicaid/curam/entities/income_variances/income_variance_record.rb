# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module IncomeVariances
        # IncomeVarianceRecord
        class IncomeVarianceRecord < Sequent::ApplicationRecord
          belongs_to :application_income_record,
                     foreign_key: "application_income_aggregate_id",
                     primary_key: "aggregate_id",
                     class_name: "::Curam::ApplicationIncomes::ApplicationIncomeRecord",
                     required: false

          def unresolved?
            status == "unresolved"
          end
        end
      end
    end
  end
end