# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for CurrentIncome.
      class CurrentIncomeContract < Dry::Validation::Contract

        params do
          optional(:most_recent_hire_date).maybe(:date)
          optional(:termination_date).maybe(:date)
          optional(:pay_rate).maybe(:integer)
          optional(:data_source_payment_frequency_code).maybe(Iap::Types::IncomeFrequency)
        end

        rule(:pay_rate) do
          if key?
            # Required if no IncomeDate in the PersonIncome, and it is not SSA-verified.
          end
        end

        rule(:data_source_payment_frequency_code) do
          if key?
            # Required for PersonIncome elements that are conveying Pay Period Information.
          end
        end
      end
    end
  end
end
