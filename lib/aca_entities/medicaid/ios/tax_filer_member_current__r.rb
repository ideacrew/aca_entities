# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for TaxFilerMemberCurrent__r
      class TaxFilerMemberCurrentR < Dry::Struct
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end