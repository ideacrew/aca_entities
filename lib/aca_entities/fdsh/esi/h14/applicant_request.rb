# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationRequest
        class ApplicantRequest < Dry::Struct

          attribute :RequestPerson,  Fdsh::Esi::H14::RequestPerson.meta(omittable: false)
          attribute :InsuranceApplicantRequest,  Fdsh::Esi::H14::InsuranceApplicantRequest.meta(omittable: false)
          attribute :PersonLocationState,  Types::String.meta(omittable: false)
        end
      end
    end
  end
end