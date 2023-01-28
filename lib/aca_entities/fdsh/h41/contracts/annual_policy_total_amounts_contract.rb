# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 AnnualPolicyTotalAmountsContract
        class AnnualPolicyTotalAmountsContract < Dry::Validation::Contract
          params do
            required(:AnnualPremiumAmt).filled(AcaEntities::Types::Money)
            required(:AnnualPremiumSLCSPAmt).filled(AcaEntities::Types::Money)
            required(:AnnualAdvancedPTCAmt).filled(AcaEntities::Types::Money)
          end
        end
      end
    end
  end
end