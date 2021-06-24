# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An identification of the policy.
          class InsurancePolicyIdentification
            include HappyMapper

            tag 'InsurancePolicyIdentification'
            namespace 'hix-ee'

            element :identification_id, String, tag: 'IdentificationID', namespace: 'nc'

            def self.domain_to_mapper(_policy)
              self.new
            end

            def to_hash
              {
                identification_id: identification_id
              }
            end
          end
        end
      end
    end
  end
end