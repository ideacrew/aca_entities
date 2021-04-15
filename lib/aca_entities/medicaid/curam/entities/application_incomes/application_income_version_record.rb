# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        # ApplicationIncomeVersionRecord
        class ApplicationIncomeVersionRecord < Sequent::ApplicationRecord
          belongs_to :application_income_record,
                     foreign_key: "application_income_aggregate_id",
                     primary_key: "aggregate_id",
                     class_name: "::Curam::ApplicationIncomes::ApplicationIncomeRecord",
                     required: false
        end
      end
    end
  end
end