# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for ChipEligibility
      class ChipEligibilityContract < Dry::Validation::Contract

        params do
          optional(:trafficking_victim_category_eligibility_basis).maybe(:hash)
        end
      end
    end
  end
end
