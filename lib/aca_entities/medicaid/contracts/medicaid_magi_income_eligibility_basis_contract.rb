# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # MedicaidMagiIncomeEligibilityBasis contract
      class MedicaidMagiIncomeEligibilityBasisContract < Dry::Validation::Contract
        params do
          optional(:status_indicator).maybe(:bool)
          required(:eligibility_basis_status_code).filled(:string)
          optional(:ineligibility_reason_text).maybe(:string)
          optional(:eligibility_basis_determination).maybe(:hash)
          optional(:state_threshold_fpl_percent).maybe(:string)
          optional(:income_compatibility).maybe(:hash)
        end
      end
    end
  end
end