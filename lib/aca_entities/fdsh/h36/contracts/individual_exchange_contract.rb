# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for h36 contract IndividualExchangeContract
        class IndividualExchangeContract < Dry::Validation::Contract
          params do
            required(:HealthExchangeId).filled(:string)
            required(:IrsHouseholdGroup).filled(AcaEntities::Fdsh::H36::Contracts::IrsHouseholdGroupContract.params)
          end
        end
      end
    end
  end
end
