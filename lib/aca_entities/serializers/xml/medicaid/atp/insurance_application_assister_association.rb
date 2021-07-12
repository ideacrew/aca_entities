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

            def self.domain_to_mapper(_reference)
              self.new
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