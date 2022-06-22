# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for SSP_InsuranceCoveredIndiv__c
      class SSPInsuranceCoveredIndivC < Dry::Struct
        attribute :DateofBirth__c, Types::Date.optional.meta(omittable: true)
        attribute :DCId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCIndividualId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCMedicaidPolicyIndividualId__c, Types::Integer.optional.meta(omittable: true)
        attribute :ExtAddressLine1__c, Types::String.optional.meta(omittable: true)
        attribute :ExtAddressLine2__c, Types::String.optional.meta(omittable: true)
        attribute :ExtCity__c, Types::String.optional.meta(omittable: true)
        attribute :ExtPolicyHolderFirstName__c, Types::String.optional.meta(omittable: true)
        attribute :ExtPolicyHolderLastName__c, Types::String.optional.meta(omittable: true)
        attribute :ExtPolicyHolderMiddleInitial__c, Types::String.optional.meta(omittable: true) # MaxStringLengthValidator(30)
        attribute :ExtPolicyHolderSsn__c, Types::Integer.optional.meta(omittable: true)
        attribute :ExtStateCode__c, Types::String.optional.meta(omittable: true)
        attribute :ExtZipCode4__c, Types::String.optional.meta(omittable: true)
        attribute :ExtZipCode5__c, Types::String.optional.meta(omittable: true)
        attribute :FirstName__c, Types::String.optional.meta(omittable: true)
        attribute :Gender__c, Types::String.optional.meta(omittable: true)
        attribute :IsEnrolled__c, Types::Boolean.optional.meta(omittable: true) # SelectAtLeast1CoverageEnrollmentValidator
        attribute :IsTobbacoConsumerToggle__c, Types::String.optional.meta(omittable: true)
        attribute :LastName__c, Types::String.optional.meta(omittable: true)
        attribute :MedicaidId__c, Types::String.optional.meta(omittable: true)
        attribute :RelationshipCode__c, Types::String.optional.meta(omittable: true)
        attribute :SSN__c, Types::String.optional.meta(omittable: true)
        attribute :SSP_Member__c, Types::String.optional.meta(omittable: true)
        attribute :SuffixCode__c, Types::String.optional.meta(omittable: true)
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
        attribute :SSP_InsurancePolicy__c, Types::String.optional.meta(omittable: true)
        attribute :IsDeleted__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsInsuranceCovered__c, Types::String.optional.meta(omittable: true)
        attribute :IsPolicyHolder__c, Types::Boolean.optional.meta(omittable: true)
        attribute :InsuranceInternalPolicyHolder__c, Types::String.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :RecordType, RecordType.optional.meta(omittable: true)
        attribute :SSP_Member__r, SSPMemberR.optional.meta(omittable: true)
      end
    end
  end
end