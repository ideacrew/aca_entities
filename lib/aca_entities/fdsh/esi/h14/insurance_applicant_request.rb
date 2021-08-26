# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationRequest
        class InsuranceApplicantRequest < Dry::Struct
          attribute :InsuranceApplicantRequestedCoverage,  Fdsh::Esi::H14::InsuranceApplicantRequestedCoverage.meta(omittable: false)
        end
      end
    end
  end
end