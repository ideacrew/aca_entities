# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 TaxHouseholdCoverageContract
        class TaxHouseholdCoverageContract < Dry::Validation::Contract
          params do
            required(:ApplicableCoverageMonthNum).filled(:string)
            optional(:Household).maybe(AcaEntities::Fdsh::H36::Contracts::HouseholdContract.params)
            optional(:OtherRelevantAdult).maybe(AcaEntities::Fdsh::H36::Contracts::OtherRelevantAdultContract.params)
          end
        end
      end
    end
  end
end