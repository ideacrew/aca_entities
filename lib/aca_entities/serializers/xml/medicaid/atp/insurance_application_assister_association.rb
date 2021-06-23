# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class InsuranceApplicationAssisterAssociation
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'InsuranceApplicationAssisterAssociation'
            namespace 'hix-ee'

            has_one :begin_date, AssociationBeginDate
            has_one :end_date, AssociationEndDate

            def self.domain_to_mapper(reference)
              mapper = self.new
              mapper
            end

            def to_hash
              {
                begin_date: begin_date&.to_hash,
                end_date: end_date&.to_hash
              }
            end
          end
        end
      end
    end
  end
end