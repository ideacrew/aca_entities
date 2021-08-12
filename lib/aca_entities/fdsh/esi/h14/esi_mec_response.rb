# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationRequest
        class ESIMECResponse < Dry::Struct
          attribute :ApplicantResponseSet,  Fdsh::Esi::H14::ApplicantResponseSet.meta(omittable: false)
        end
      end
    end
  end
end