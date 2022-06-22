# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module IOS
      # entity for Contact
      class Contact < Dry::Struct
        attribute :AddressTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :AgencyEmployeeId__c, Types::Integer.optional.meta(omittable: true)
        attribute :AssociationStartDate__c, Types::Date.optional.meta(omittable: true)
        attribute :Birthdate, Types::Date.optional.meta(omittable: true)
        attribute :Email, Types::String.optional.meta(omittable: true) # EmailAddressValidator
        attribute :FirstName, Types::String.meta(omittable: false)
        attribute :LastName, Types::String.meta(omittable: false)
        attribute :GenderCode__c, Types::String.optional.meta(omittable: true)
        attribute :MailingAddressLine2__c, Types::String.optional.meta(omittable: true) # AddressLine2Validator
        attribute :OrganizationName__c, Types::Integer.optional.meta(omittable: true)
        attribute :OrgranizationIdentificationNumber__c, Types::Date.optional.meta(omittable: true)
        attribute :PreferredLanguageCode__c, Types::String.optional.meta(omittable: true)
        attribute :PrimaryPhoneExtension__c, Types::Integer.optional.meta(omittable: true)
        attribute :PrimaryPhoneNumber__c, Types::String.optional.meta(omittable: true)
        attribute :RepresentativeProgramCode__c, Types::String.optional.meta(omittable: true)
        attribute :SSN__c, Types::String.optional.meta(omittable: true)
        attribute :SuffixCode__c, Types::String.optional.meta(omittable: true)
        attribute :IndividualId__c, Types::String.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :MiddleName, Types::String.optional.meta(omittable: true)
        attribute :Phone, Types::String.optional.meta(omittable: true)
        attribute :DCDataId__c, Types::Integer.optional.meta(omittable: true)
        attribute :PreferredLanguageCode__c, Types::String.optional.meta(omittable: true)
        attribute :IsManualAuthRep__c, Types::Boolean.optional.meta(omittable: true)
        attribute :RecordType, RecordType.optional.meta(omittable: true)
        attribute :AgencyOrOrganization__r, AgencyOrOrganization__r.optional.meta(omittable: true)
      end
    end
  end
end