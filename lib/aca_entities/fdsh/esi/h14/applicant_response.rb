# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationRequest
        class ApplicantResponse < Dry::Struct
          attribute :ResponsePerson,  Fdsh::Esi::H14::ResponsePerson.meta(omittable: false)
          attribute :ResponseMetadata,  Fdsh::Esi::H14::ResponseMetadata.meta(omittable: false)
          attribute :ApplicantMECInformation,  Fdsh::Esi::H14::ApplicantMECInformation.optional.meta(omittable: true)
        end
      end
    end
  end
end