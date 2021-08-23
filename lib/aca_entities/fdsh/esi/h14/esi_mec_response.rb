# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationRequest
        class ESIMECResponse < Dry::Struct
          attribute :ApplicantResponseSet,  Fdsh::Esi::H14::ApplicantResponseSet.optional.meta(omittable: true)
          attribute :ResponseMetadata,  AcaEntities::Fdsh::Esi::H14::ResponseMetaData.optional.meta(omittable: true)
        end
      end
    end
  end
end