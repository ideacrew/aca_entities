# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a relationship between a person and contact information.
          class PersonContactInformationAssociation
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'PersonContactInformationAssociation'
            namespace 'hix-core'

            has_one :begin_date, AssociationBeginDate 
            has_one :end_date, AssociationEndDate 
            has_one :contact, ContactInformation

            # A kind of contact information.
            element :category_code, String, tag: 'ContactInformationCategoryCode', namespace:'hix-core'

            # A kind of contact information.
            element :is_primary_indicator, Boolean, tag: 'ContactInformationIsPrimaryIndicator', namespace:'nc'

            def self.domain_to_mapper(expense)
              mapper = self.new
              mapper
            end

            def to_hash
              {
                begin_date: begin_date&.to_hash,
                end_date: end_date&.to_hash,
                contact: contact&.to_hash,
                category_code: category_code,
                is_primary_indicator: is_primary_indicator
              }
            end
          end
        end
      end
    end
  end
end