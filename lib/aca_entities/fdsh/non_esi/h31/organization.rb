# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) VerificationRequest
        class Organization < Dry::Struct
          attribute :OrganizationCodes, Types::Array.of(AcaEntities::Fdsh::Types::TDSOrganizationCode).meta(omittable: false)
        end
      end
    end
  end
end