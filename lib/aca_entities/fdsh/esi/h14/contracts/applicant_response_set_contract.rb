# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class ApplicantResponseSetContract < Dry::Validation::Contract
            params do
              required(:ApplicantResponse).filled(AcaEntities::Fdsh::Esi::H14::Contracts::ApplicantResponseContract.params)
            end
          end
        end
      end
    end
  end
end