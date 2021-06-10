# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class SsfSigner
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'SSFSigner'
            namespace 'hix-ee'

            has_one :role_reference, RoleOfPersonReference
            has_one :signature, Signature
            has_one :ssf_attestation, SsfAttestation

            element :signer_authorized_representative_association, String, tag: 'SSFSignerAuthorizedRepresentativeAssociation', namespace: 'hix-ee'
            element :attestation, String, tag: 'SSFAttestation', namespace: 'hix-ee'

            def self.domain_to_mapper(insurance_application)
              mapper = self.new
              mapper.role_reference = RoleOfPersonReference.domain_to_mapper(insurance_application)
              mapper.signature = Signature.domain_to_mapper(insurance_application)
              mapper.ssf_attestation = SsfAttestation.domain_to_mapper(insurance_application)
              mapper
            end

          end
        end
      end
    end
  end
end
