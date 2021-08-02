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

            has_one :role_reference, RoleOfPersonReference

            has_one :signature, Signature

            has_one :ssf_signer_authorized_representative_association, SsfSignerAuthorizedRepresentativeAssociation

            has_one :ssf_attestation, SsfAttestation

            def self.domain_to_mapper(signer)
              mapper = self.new
              mapper.role_reference = RoleOfPersonReference.domain_to_mapper(signer.role_reference)
              mapper.signature = Signature.domain_to_mapper(signer.signature)
              if signer.ssf_signer_authorized_representative_association
                mapper.ssf_signer_authorized_representative_association =
                  SsfSignerAuthorizedRepresentativeAssociation.domain_to_mapper(signer.ssf_signer_authorized_representative_association)
              end
              mapper.ssf_attestation = SsfAttestation.domain_to_mapper(signer.ssf_attestation)
              mapper
            end

            def to_hash
              {
                role_reference: role_reference&.to_hash,
                signature: signature&.to_hash,
                ssf_signer_authorized_representative_association: ssf_signer_authorized_representative_association&.to_hash,
                ssf_attestation: ssf_attestation&.to_hash
              }
            end
          end
        end
      end
    end
  end
end