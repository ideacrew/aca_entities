# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A person that files a tax return as a spouse.
          class SpouseTaxFiler
            include HappyMapper

            tag 'SpouseTaxFiler'
            namespace 'hix-ee'

            has_one :role_reference, RoleOfPersonReference

            def self.domain_to_mapper(filer)
              mapper = self.new
              mapper.role_reference = RoleOfPersonReference.domain_to_mapper(filer.role_reference)
              mapper
            end

            def to_hash
              {
                role_reference: role_reference&.to_hash
              }
            end
          end
        end
      end
    end
  end
end