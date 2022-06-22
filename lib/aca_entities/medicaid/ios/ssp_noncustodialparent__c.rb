# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module IOS
      # entity for SSP_NonCustodialParent__c
      class SSP_NonCustodialParent__c < Dry::Struct
        attribute :FirstName__c, Types::String.meta(omittable: false)
        attribute :LastName__c, Types::String.meta(omittable: false)
        attribute :MiddleInitial__c, Types::String.optional.meta(omittable: true)
        attribute :SSN__c, Types::String.optional.meta(omittable: true)
        attribute :SuffixCode__c, Types::String.optional.meta(omittable: true)
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
        attribute :GenderCode__c, Types::String.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :DCNonCustodialParentId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DateOfBirth__c, Types::Date.optional.meta(omittable: true)
        attribute :IsParentUnknown__c, Types::Boolean.optional.meta(omittable: true)
        attribute :RecordType, RecordType.optional.meta(omittable: true)
      end
    end
  end
end