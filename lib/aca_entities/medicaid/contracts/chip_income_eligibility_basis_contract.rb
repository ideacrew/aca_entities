# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for ChipIncomeEligibilityBasisContract
      class ChipIncomeEligibilityBasisContract < Dry::Validation::Contract

        params do
          optional(:status_indicator).maybe(:bool)
          required(:status_code).filled(:string)
          # optional(:inconsistency_reason).maybe(:string)
          # optional(:ineligibility_reason).maybe(:string)
          # optional(:status_determination_date).maybe(:date_time)
          # optional(:applicable_chip_standard).maybe(:integer)
        end
      end
    end
  end
end
