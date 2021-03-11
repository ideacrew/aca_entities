# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for ChipIncomeBasisContract
      class ChipIncomeBasisContract < Dry::Validation::Contract

        params do
          required(:status_code).filled(:string)
          optional(:status_indicator).maybe(:bool)
          optional(:inconsistency_reason).maybe(:string)
          optional(:ineligibility_reason).maybe(:string)
          optional(:status_determination_date).maybe(:date_time)
          optional(:applicable_chip_standard).maybe(:integer)
        end

      end
    end
  end
end
