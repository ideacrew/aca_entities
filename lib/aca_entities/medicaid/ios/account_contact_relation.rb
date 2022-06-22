# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module IOS
      # entity for AccountContactRelation
      class AccountContactRelation < Dry::Struct
        attribute :DCRepresentativeId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCContactId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCAgencyId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCDataId__c, Types::Integer.optional.meta(omittable: true)
        attribute :IsRepresentativeVerified__c, Types::String.optional.meta(omittable: true)
        attribute :AddressLine1__c, Types::String.meta(omittable: false)
        attribute :AddressLine2__c, Types::String.optional.meta(omittable: true)
        attribute :Street__c, Types::String.optional.meta(omittable: true)
        attribute :City__c, Types::String.meta(omittable: false)
        attribute :StateCode__c, Types::String.meta(omittable: false)
        attribute :Zipcode5__c, Types::String.optional.meta(omittable: true)
        attribute :Zipcode4__c, Types::String.optional.meta(omittable: true)
        attribute :CountyCode__c, Types::String.optional.meta(omittable: true)
        attribute :IsAddressValidated__c, Types::Boolean.optional.meta(omittable: true)
        attribute :ContactId, Types::String.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :Roles, Types::String.optional.meta(omittable: true)
        attribute :ProgramsApplied__c, Types::String.optional.meta(omittable: true)
        attribute :PermissionLevel_Medicaid__c, Types::String.optional.meta(omittable: true)
        attribute :PermissionLevel_SNAP__c, Types::String.optional.meta(omittable: true)
        attribute :PermissionLevel_StateSupp__c, Types::String.optional.meta(omittable: true)
        attribute :PermissionLevel_KIHIPP__c, Types::String.optional.meta(omittable: true)
        attribute :PermissionLevel_KTAP__c, Types::String.optional.meta(omittable: true)
        attribute :PermissionLevel_CCAP__c, Types::String.optional.meta(omittable: true)
        attribute :StartDate, Types::Date.optional.meta(omittable: true)
        attribute :RepresentativeRelationshipCode__c, Types::String.optional.meta(omittable: true)
        attribute :Contact, Contact.meta(omittable: false)
      end
    end
  end
end