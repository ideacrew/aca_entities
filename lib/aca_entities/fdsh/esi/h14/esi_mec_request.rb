# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationRequest
        class ESIMECRequest < Dry::Struct
          attribute :ApplicantRequests,  Types::Array.of(Fdsh::Esi::H14::ApplicantRequest).meta(omittable: false)
        end
      end
    end
  end
end