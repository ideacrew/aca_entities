# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 MonthlyPremiumInformationContract
        class MonthlyPremiumInformationContract < Dry::Validation::Contract
          params do
            required(:MonthlyPremiumAmt).filled(:float)
            required(:MonthlyPremiumSLCSPAmt).filled(:float)
            required(:MonthlyAdvancedPTCAmt).filled(:float)
          end
        end
      end
    end
  end
end