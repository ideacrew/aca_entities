# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) VerificationRequest
        class VerifyNonESIMECRequest < Dry::Struct
          attribute :IndividualRequests,  Types::Array.of(Fdsh::NonEsi::H31::IndividualRequest).meta(omittable: false)
        end
      end
    end
  end
end