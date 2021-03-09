# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for CurrentIncome.
    class CurrentIncomeContract < Dry::Validation::Contract

      params do
        optional(:most_recent_hire_date).maybe(:date)
        optional(:termination_date).maybe(:date)
      end
    end
  end
end
