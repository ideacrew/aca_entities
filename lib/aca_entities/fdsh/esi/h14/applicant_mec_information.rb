# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationResponse
        class ApplicantMECInformation < Dry::Struct
          attribute :InsuranceApplicantResponse, Fdsh::Esi::H14::InsuranceApplicantResponse.meta(omittable: false)
          attribute :InconsistencyIndicator, Types::Bool.meta(omittable: false)

          attribute :MonthlyPremiumAmount, Fdsh::Esi::H14::MonthlyPremiumAmount.optional.meta(omittable: true)

        end
      end
    end
  end
end