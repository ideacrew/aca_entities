# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An identification of the policy.
          class InsurancePolicyIdentification
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'InsurancePolicyIdentification'
            namespace 'hix-ee'

            element :identification_id, String, tag: 'IdentificationID', namespace: 'nc'

            def self.domain_to_mapper(policy)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end