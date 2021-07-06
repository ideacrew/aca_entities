# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for IncomeFrequency
      class IncomeFrequencyContract < Dry::Validation::Contract

        params do
          optional(:frequency_code).maybe(:string)
        end
      end
    end
  end
end
