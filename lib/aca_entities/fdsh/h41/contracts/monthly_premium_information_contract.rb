# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 MonthlyPremiumInformationContract
        class MonthlyPremiumInformationContract < Dry::Validation::Contract
          params do
            required(:MonthlyPremiumAmt).filled(AcaEntities::Types::Money)
            required(:MonthlyPremiumSLCSPAmt).filled(AcaEntities::Types::Money)
            required(:MonthlyAdvancedPTCAmt).filled(AcaEntities::Types::Money)
          end
        end
      end
    end
  end
end