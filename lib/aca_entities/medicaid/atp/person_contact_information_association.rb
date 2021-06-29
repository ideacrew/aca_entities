# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonContactInformationAssociation
      class PersonContactInformationAssociation < Dry::Struct
        # attribute :begin_date, AssociationBeginDate 
        # attribute :end_date, AssociationEndDate 
        attribute :contact, ContactInformation.optional.meta(omittable: true)
        attribute :category_code, Types::String.optional.meta(omittable: true)
        # attribute :is_primary_indicator, Types::Boolean
      end
    end
  end
end