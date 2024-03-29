# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationResponse
        class InsuranceApplicantResponse < Dry::Struct
          attribute :InsuranceApplicantRequestedCoverage, Fdsh::Esi::H14::InsuranceApplicantRequestedCoverage.meta(omittable: false)
          attribute :InsuranceApplicantEligibleEmployerSponsoredInsuranceIndicator, Types::Bool.optional.meta(omittable: true)
          attribute :InsuranceApplicantInsuredIndicator, Types::Bool.optional.meta(omittable: true)
        end
      end
    end
  end
end