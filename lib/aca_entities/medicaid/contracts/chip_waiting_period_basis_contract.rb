# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for ChipWaitingPeriodBasis
      class ChipWaitingPeriodBasisContract < Dry::Validation::Contract
        params do
          required(:satisfied_code).filled(:string)
          optional(:satisfied_indicator).maybe(:bool)
          optional(:determination_date).maybe(:date_time)
          optional(:ineligibility_reason).maybe(:string)
        end
      end
    end
  end
end
