# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for ios AgencyOrOrganization__r
      class AgencyOrOrganizationR < Dry::Struct
        attribute :DCDataId__c, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end