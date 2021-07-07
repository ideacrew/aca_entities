# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp SSF Signer
      class SsfSigner < Dry::Struct
        attribute :role_reference, RoleOfPersonReference.meta(omittable: false)
        attribute :signature, Signature.optional.meta(omittable: true)
        attribute :ssf_signer_authorized_representative_association, SsfSignerAuthorizedRepresentativeAssociation.optional.meta(omittable: true)
        attribute :ssf_attestation, SsfAttestation.optional.meta(omittable: true)
      end
    end
  end
end
