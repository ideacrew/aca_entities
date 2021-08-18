# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class InsuranceApplicantRequestContract < Dry::Validation::Contract
          params do
            required(:InsuranceApplicantRequestedCoverage)
              .filled(AcaEntities::Fdsh::Esi::H14::InsuranceApplicantRequestedCoverageContract.params)
            # optional(:InsuranceApplicantEligibleEmployerSponsoredInsuranceIndicator).maybe(:bool)
            # optional(:InsuranceApplicantInsuredIndicator).maybe(:bool)
          end
        end
      end
    end
  end
end