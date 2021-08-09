# frozen_string_literal: true

require_relative 'eligibility_basis_contract'

module AcaEntities
  module Medicaid
    module Contracts
      # MedicaidMagiIncomeEligibilityBasis contract
      class MedicaidMagiIncomeEligibilityBasisContract < EligibilityBasisContract
        params do

          # Additional params
          optional(:state_threshold_fpl_percent).maybe(:string)
          optional(:income_compatibility).maybe(:hash)
        end
      end
    end
  end
end