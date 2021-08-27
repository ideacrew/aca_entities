# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) VerificationResponse
        class VerifyNonESIMECResponse < Dry::Struct
          attribute :ResponseMetadata,  AcaEntities::Fdsh::NonEsi::H31::ResponseMetadata.optional.meta(omittable: true)
          attribute :IndividualResponseSet, AcaEntities::Fdsh::NonEsi::H31::IndividualResponseSet.optional.meta(omittable: true)
        end
      end
    end
  end
end