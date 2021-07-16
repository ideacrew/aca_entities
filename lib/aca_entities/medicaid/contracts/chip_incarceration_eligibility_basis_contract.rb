# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for ChipIncarcerationEligibilityBasis
      class ChipIncarcerationEligibilityBasisContract < Dry::Validation::Contract

        params do
          optional(:status_indicator).maybe(:bool)
          optional(:status_valid_date_range).maybe(:hash)
          required(:status_code).filled(:string)
          optional(:ineligibility_reason_text).maybe(:string)
          optional(:inconsistency_reason_text).maybe(:string)
          optional(:pending_reason_text).maybe(:string)
          optional(:determination).maybe(:hash)
        end
      end
    end
  end
end
