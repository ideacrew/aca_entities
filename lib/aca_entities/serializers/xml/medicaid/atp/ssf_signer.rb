# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a relationship between a Single Streamlined Form (SSF) signer and an authorized representative.
          class SsfSigner
            include HappyMapper

            tag 'SSFSigner'
            namespace 'hix-ee'

            has_one :signature, Signature

            has_one :ssf_signer_authorized_representative_association, SsfSignerAuthorizedRepresentativeAssociation

            has_one :ssf_attestation, SsfAttestation

            def self.domain_to_mapper(signer)
              self.new
            end

            def to_hash
              {
                signature: signature.to_hash,
                ssf_signer_authorized_representative_association: ssf_signer_authorized_representative_association.to_hash,
                ssf_attestation: ssf_attestation.to_hash
              }
            end
          end
        end
      end
    end
  end
end