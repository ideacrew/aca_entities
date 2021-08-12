# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class ApplicantMECInformationContract < Dry::Validation::Contract
            params do
              required(:InsuranceApplicantResponse).filled(AcaEntities::Fdsh::Esi::H14::Contracts::InsuranceApplicantResponseContract.params)
              required(:InconsistencyIndicator).filled(:bool)
              optional(:MonthlyPremiumAmount).maybe(AcaEntities::Fdsh::Esi::H14::Contracts::MonthlyPremiumAmountContract.params)
            end
          end
        end
      end
    end
  end
end