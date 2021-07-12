# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for MedicaidMagiEligibility
      class MedicaidMagiEligibilityContract < Dry::Validation::Contract

        params do
          optional(:eligibility_determination).maybe(:hash)
        end
      end
    end
  end
end
