# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PayPeriodInformation.
      class PayPeriodInformationContract < Dry::Validation::Contract

        params do
          optional(:end_date).maybe(:date)
          optional(:hours_worked_in_pay_period).maybe(:integer)
          optional(:data_source_income_type_amount).maybe(:float)
        end
      end
    end
  end
end
