# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationRequest
        class ApplicantResponseSet < Dry::Struct
          attribute :ApplicantResponses,  Types::Array.of(Fdsh::Esi::H14::ApplicantResponse).meta(omittable: false)
        end
      end
    end
  end
end