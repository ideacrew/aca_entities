# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        # ApplicationIncomeRecord
        class ApplicationIncomeRecord < Sequent::ApplicationRecord
          has_many :income_variance_records,
                   foreign_key: "application_income_aggregate_id",
                   primary_key: "aggregate_id",
                   class_name: "::Curam::IncomeVariances::IncomeVarianceRecord"
        end
      end
    end
  end
end