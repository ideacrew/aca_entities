# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class InsuranceApplicationAssisterAssociation
            include HappyMapper

            tag 'InsuranceApplicationAssisterAssociation'
            namespace 'hix-ee'

            has_one :begin_date, AssociationBeginDate
            has_one :end_date, AssociationEndDate

            has_one :assister_reference, InsuranceApplicationAssisterReference

            def self.domain_to_mapper(association)
              mapper = self.new
              mapper.begin_date = AssociationBeginDate.domain_to_mapper(association.association)
              mapper.end_date = AssociationEndDate.domain_to_mapper(association.association)
              mapper.assister_reference = InsuranceApplicationAssisterReference.domain_to_mapper(association.assister_reference)
              mapper
            end

            def to_hash
              {
                begin_date: begin_date&.to_hash,
                end_date: end_date&.to_hash,
                assister_reference: assister_reference&.to_hash
              }
            end
          end
        end
      end
    end
  end
end