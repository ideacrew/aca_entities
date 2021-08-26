# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a person who signs a Single Streamlined Form (SSF) insurance application, including the attestations,
          # and is therefore able to make decisions regarding the application (including assigning an authorized representative).
          class SsfSignerAuthorizedRepresentativeAssociation
            include HappyMapper

            tag 'SSFSignerAuthorizedRepresentativeAssociation'
            namespace 'hix-ee'

            has_one :signature, Signature

            has_one :authorized_representative_reference, AuthorizedRepresentativeReference

            def self.domain_to_mapper(rep)
              mapper = self.new
              mapper.signature = Signature.domain_to_mapper(rep.signature)
              mapper.authorized_representative_reference = AuthorizedRepresentativeReference.domain_to_mapper(rep.authorized_representative_reference)
              mapper
            end

            def to_hash
              {
                signature: signature&.to_hash,
                authorized_representative_reference: authorized_representative_reference&.to_hash
              }
            end
          end
        end
      end
    end
  end
end