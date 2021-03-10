# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for BasisForIncome.
    class BasisForIncomeContract < Dry::Validation::Contract

      params do
        optional(:ssa_citizenship_status).maybe(:bool)
      end
    end
  end
end
