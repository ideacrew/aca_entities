# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class ApplicantMECInformationContract < Dry::Validation::Contract
          params do
            required(:InsuranceApplicantResponse).filled(AcaEntities::Fdsh::Esi::H14::InsuranceApplicantResponseContract.params)
            required(:InconsistencyIndicator).filled(:bool)
            optional(:MonthlyPremiumAmount).maybe(AcaEntities::Fdsh::Esi::H14::MonthlyPremiumAmountContract.params)
          end
        end
      end
    end
  end
end