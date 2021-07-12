# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for ChipTraffickingVictimCategoryEligibilityBasis
      class ChipTraffickingVictimCategoryEligibilityBasisContract < Dry::Validation::Contract
        params do
          optional(:status_indicator).maybe(:bool)
        end
      end
    end
  end
end
