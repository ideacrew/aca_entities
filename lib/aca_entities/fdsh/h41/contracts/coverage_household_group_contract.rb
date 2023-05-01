# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 CoverageHouseholdGroupContract
        class CoverageHouseholdGroupContract < Dry::Validation::Contract
          params do
            required(:CoveredIndividuals).array(AcaEntities::Fdsh::H41::Contracts::CoveredIndividualContract.params)
          end
        end
      end
    end
  end
end