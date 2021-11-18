# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a person claimed as a tax dependent.
          class TaxDependent
            include HappyMapper

            tag 'TaxDependent'
            namespace 'hix-ee'

            has_one :role_reference, RoleOfPersonReference
            has_one :tin_identification, TinIdentification
            element :claimed_by_custodial_parent_indicator, Boolean, tag: 'TaxDependentClaimedByCustodialParentIndicator'

            def self.domain_to_mapper(filer)
              mapper = self.new
              mapper.claimed_by_custodial_parent_indicator = filer.claimed_by_custodial_parent_indicator
              mapper.role_reference = RoleOfPersonReference.domain_to_mapper(filer.role_reference)
              mapper.tin_identification = TinIdentification.domain_to_mapper(filer.tin_identification) if filer.tin_identification
              mapper
            end

            def to_hash
              {
                role_reference: role_reference&.to_hash,
                tin_identification: tin_identification&.to_hash,
                claimed_by_custodial_parent_indicator: claimed_by_custodial_parent_indicator
              }
            end
          end
        end
      end
    end
  end
end