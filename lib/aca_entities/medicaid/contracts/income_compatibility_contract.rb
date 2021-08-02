# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for IncomeCompatibility
      class IncomeCompatibilityContract < Dry::Validation::Contract

        params do
          optional(:verification_indicator).maybe(:bool)
          optional(:inconsistency_reason_text).maybe(:string)
          optional(:compatibility_determination).maybe(:hash)
          optional(:verification_method).maybe(:string)
        end
      end
    end
  end
end
