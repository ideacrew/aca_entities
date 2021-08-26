# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Income frequency contract
      class IncomeFrequencyContract < Dry::Validation::Contract
        params do
          required(:frequency_code).filled(:string)
        end
      end
    end
  end
end