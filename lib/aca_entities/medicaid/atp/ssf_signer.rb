# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp SsfSigner
      class SsfSigner < Dry::Struct

        attribute :ssf_attestation, SsfAttestation.optional.meta(omittable: true)
      end
    end
  end
end
