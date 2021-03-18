module Ehs
  module ApplicationIncomes
    class ApplicationIncomeImportRowContract < ::Ehs::ApplicationContract
      params do
        required(:category).filled(:string)
        required(:case_id).filled(:string)
        required(:status).filled(:string)
        required(:case_reference).filled(:string)
        required(:case_kind).filled(:string)
        required(:application_id).filled(:string)
        required(:program_kind).filled(:string)
        required(:evidence_descriptor_id).filled(:string)
        required(:frequency).filled(:string)
        required(:kind).filled(:string)
        required(:version).filled(:string)
        required(:amount).filled(:decimal)
        required(:created_on).filled(:date_time)
        required(:start_date).filled(:date)

        optional(:end_date).maybe(:date)
        optional(:last_update_on).maybe(:date_time)
        optional(:deduction_amount).maybe(:decimal)
        optional(:last_payment_date).maybe(:date)
      end
    end
  end
end
