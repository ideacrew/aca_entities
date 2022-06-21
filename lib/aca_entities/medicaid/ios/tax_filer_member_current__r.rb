# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module IOS
      # entity for TaxFilerMemberCurrent__r
      class TaxFilerMemberCurrent__r < Dry::Struct
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end