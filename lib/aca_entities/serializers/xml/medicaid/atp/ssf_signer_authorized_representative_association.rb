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

            element :signature, String, tag: 'Signature'

            has_one :authorized_representative_reference, AuthorizedRepresentativeReference

            def self.domain_to_mapper(_representative)
              self.new
            end

            def to_hash
              {
                signature: signature,
                authorized_representative_reference: authorized_representative_reference&.to_hash
              }
            end
          end
        end
      end
    end
  end
end