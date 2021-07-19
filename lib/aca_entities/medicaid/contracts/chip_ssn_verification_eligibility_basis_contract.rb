# frozen_string_literal: true

require_relative 'eligibility_basis_contract'

module AcaEntities
  module Medicaid
    module Contracts
      # contract for ChipSsnVerificationEligibilityBasis
      class ChipSsnVerificationEligibilityBasisContract < EligibilityBasisContract

        params do
          required(:status_code).filled(:string)
          optional(:status_indicator).maybe(:bool)
          optional(:determination_date).maybe(:date_time)
          optional(:inconsistency_reason).maybe(:string)
        end
      end
    end
  end
end
