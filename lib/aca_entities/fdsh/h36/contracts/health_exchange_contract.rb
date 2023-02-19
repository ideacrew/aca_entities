# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 HealthExchangeContract
        class HealthExchangeContract < Dry::Validation::Contract
          params do
            required(:SubmissionYr).filled(:string)
            required(:SubmissionMonthNum).filled(:string)
            required(:ApplicableCoverageYr).filled(:string)
            required(:IndividualExchange).filled(AcaEntities::Fdsh::H36::Contracts::IndividualExchangeContract.params)
          end
        end
      end
    end
  end
end