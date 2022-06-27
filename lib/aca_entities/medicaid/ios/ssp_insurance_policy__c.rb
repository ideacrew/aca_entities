# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for SSP_InsurancePolicy__c
      class SspInsurancePolicyC < Dry::Struct
        attribute :DCId__c, Types::Integer.optional.meta(omittable: true)
        attribute :Is_this_an_empl__c, Types::String.meta(omittable: false)
        attribute :InsuranceCompanyName__c, Types::String.optional.meta(omittable: true)
        attribute :InsuranceGroupNumber__c, Types::String.optional.meta(omittable: true)
        attribute :InsurancePolicyNumber__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalAddressLine1__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalAddressLine2__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalCity__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalCountryCode__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalStateCode__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalZipCode4__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalZipCode5__c, Types::String.optional.meta(omittable: true)
        attribute :PlanName__c, Types::String.optional.meta(omittable: true)
        attribute :PolicyBeginDate__c, Types::String.optional.meta(omittable: true)
        attribute :TypeOfCoverageCode__c, Types::String.optional.meta(omittable: true)
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
        attribute :EnrollmentTierLevel__c, Types::String.optional.meta(omittable: true)
        attribute :IsPolicyUpdated__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsEnrolledInInsurance__c, Types::Boolean.meta(omittable: false)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :IsDeleted__c, Types::Boolean.optional.meta(omittable: true)
        attribute :DCEmploymentDetailId__c, Types::Integer.optional.meta(omittable: true)
        attribute :EmployerName__c, Types::String.optional.meta(omittable: true)
        attribute :IsHealthCareCovPolicyHolderOutSideCase__c, Types::Boolean.optional.meta(omittable: true)
      end
    end
  end
end