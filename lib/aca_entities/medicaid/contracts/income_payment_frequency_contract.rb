# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Income payment frequency contract
      class IncomePaymentFrequencyContract < Dry::Validation::Contract
        params do
          required(:frequency_code).filled(:string)
        end
      end
    end
  end
end