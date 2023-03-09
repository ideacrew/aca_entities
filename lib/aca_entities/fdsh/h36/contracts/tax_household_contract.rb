# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 TaxHouseholdContract
        class TaxHouseholdContract < Dry::Validation::Contract
          params do
            required(:TaxHouseholdCoverages).array(AcaEntities::Fdsh::H36::Contracts::TaxHouseholdCoverageContract.params)
          end
        end
      end
    end
  end
end