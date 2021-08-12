# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class ApplicantRequestContract < Dry::Validation::Contract
            params do
              required(:RequestPerson).filled(AcaEntities::Fdsh::Esi::H14::Contracts::RequestPersonContract.params)
              required(:InsuranceApplicantRequest).filled(AcaEntities::Fdsh::Esi::H14::Contracts::InsuranceApplicantRequestContract.params)
              required(:PersonLocationState).filled(:string)
            end
          end
        end
      end
    end
  end
end