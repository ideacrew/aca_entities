# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationRequest
        class InsuranceApplicantRequestedCoverage < Dry::Struct
          attribute :StartDate,  Types::Date.meta(omittable: false)
          attribute :EndDate,  Types::Date.meta(omittable: false)
        end
      end
    end
  end
end