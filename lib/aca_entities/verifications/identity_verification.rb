# frozen_string_literal: true

module AcaEntities
  module Verifications
    # This will help us to isolate the types of services we use to verify the identity of a person
    class IdentityVerification < Dry::Struct

      attribute :ridp_attestations, Types::Array.of(AcaEntities::Attestations::RidpAttestation).meta(omittable: true)
    end
  end
end

