# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class InsuranceApplicantRequestedCoverageContract < Dry::Validation::Contract
            params do
              required(:StartDate).filled(AcaEntities::Fdsh::Esi::H14::Contracts::DateContract.params)
              required(:EndDate).filled(AcaEntities::Fdsh::Esi::H14::Contracts::DateContract.params)
            end
          end
        end
      end
    end
  end
end