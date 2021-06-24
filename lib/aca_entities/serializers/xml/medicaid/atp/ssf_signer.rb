# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a relationship between a Single Streamlined Form (SSF) signer and an authorized representative.
          class SsfSigner
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'SsfSigner'
            namespace 'hix-ee'

            has_one :authorized_representative_reference, Signature

            has_one :ssf_signer_authorized_representative_association, SsfSignerAuthorizedRepresentativeAssociation

            has_one :ssf_attestation, SsfAttestation

            def self.domain_to_mapper(_signer)
              self.new
            end

            def to_hash
              {
                # revisit this element
                # AuthorizedRepresentativeReference: AuthorizedRepresentativeReference
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