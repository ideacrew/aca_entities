# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 AssociatedPolicyContract
        class AssociatedPolicyContract < Dry::Validation::Contract
          params do
            required(:QHPPolicyNum).filled(:string)
            required(:QHPIssuerEIN).filled(:string)
            required(:SLCSPAdjMonthlyPremiumAmt).filled(:float)
            required(:HouseholdAPTCAmt).filled(:float)
            required(:TotalHsldMonthlyPremiumAmt).filled(:float)
          end
        end
      end
    end
  end
end