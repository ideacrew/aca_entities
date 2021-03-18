module Ehs
  module ApplicationIncomes
    class ApplicationIncomeRecord < Sequent::ApplicationRecord
      has_many :income_variance_records,
        foreign_key: "application_income_aggregate_id",
        primary_key: "aggregate_id",
        class_name: "::Ehs::IncomeVariances::IncomeVarianceRecord"
    end
  end
end