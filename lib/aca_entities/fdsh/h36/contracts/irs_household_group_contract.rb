# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 IrsHouseholdGroupContract
        class IrsHouseholdGroupContract < Dry::Validation::Contract
          params do
            required(:IrsGroupIdentificationNumber).filled(:string)
            required(:TaxHouseholds).array(AcaEntities::Fdsh::H36::Contracts::TaxHouseholdContract.params)
            required(:InsurancePolicies).array(AcaEntities::Fdsh::H36::Contracts::InsurancePolicyContract.params)
          end
        end
      end
    end
  end
end