# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 AnnualPolicyTotalAmountsContract
        class AnnualPolicyTotalAmountsContract < Dry::Validation::Contract
          params do
            required(:AnnualPremiumAmt).filled(:float)
            required(:AnnualPremiumSLCSPAmt).filled(:float)
            required(:AnnualAdvancedPTCAmt).filled(:float)
          end
        end
      end
    end
  end
end