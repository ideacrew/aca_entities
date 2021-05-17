# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class InsuranceApplicant
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'InsuranceApplicant'
            namespace 'hix-ee'

            has_one :role_reference, RoleOfPersonReference

            def self.domain_to_mapper(insurance_application)
              mapper = self.new
              mapper.role_reference = RoleOfPersonReference.domain_to_mapper(insurance_application)
              mapper
            end
          end
        end
      end
    end
  end
end