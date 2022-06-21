# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module IOS
      # entity for ios AgencyOrOrganization__r
      class AgencyOrOrganization__r < Dry::Struct
        attribute :DCDataId__c, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end