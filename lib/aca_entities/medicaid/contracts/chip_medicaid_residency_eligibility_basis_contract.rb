# frozen_string_literal: true

require_relative 'eligibility_basis_contract'

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for ChipMedicaidResidencyEligibilityBasis
      class ChipMedicaidResidencyEligibilityBasisContract < EligibilityBasisContract

        params do
          # required(:status_code).filled(:string)
          # optional(:status_indicator).maybe(:bool)
          # optional(:status_determination_date).maybe(:date_time)
          # optional(:ineligibility_reason).maybe(:string)
        end
      end
    end
  end
end
