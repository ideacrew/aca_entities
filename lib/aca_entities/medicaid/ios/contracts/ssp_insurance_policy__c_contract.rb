# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_InsurancePolicy__c
        class SspInsurancePolicyCContract < Dry::Validation::Contract
          params do
            # optional(:DCId__c).maybe(:integer)
            required(:Is_this_an_empl__c).filled(:string)
            # optional(:InsuranceCompanyName__c).maybe(:string)
            # optional(:InsuranceGroupNumber__c).maybe(:string)
            # optional(:InsurancePolicyNumber__c).maybe(:string)
            # optional(:PhysicalAddressLine1__c).maybe(:string)
            # optional(:PhysicalAddressLine2__c).maybe(:string)
            # optional(:PhysicalCity__c).maybe(:string)
            # optional(:PhysicalCountryCode__c).maybe(:string)
            # optional(:PhysicalStateCode__c).maybe(:string)
            # optional(:PhysicalZipCode4__c).maybe(:string)
            # optional(:PhysicalZipCode5__c).maybe(:string)
            # optional(:PlanName__c).maybe(:string)
            optional(:PolicyBeginDate__c).maybe(:date)
            optional(:TypeOfCoverageCode__c).maybe(:string)
            # optional(:IndividualId__c).maybe(:integer) #this makes no sense, how we will match it without an ID ?
            required(:EnrollmentTierLevel__c).filled(:string)
            optional(:IsPolicyUpdated__c).maybe(:bool)
            required(:IsEnrolledInInsurance__c).filled(:bool)
            optional(:Id).maybe(:string)
            # optional(:IsDeleted__c).maybe(:bool)
            # optional(:DCEmploymentDetailId__c).maybe(:integer)
            optional(:EmployerName__c).maybe(:string)
            optional(:IsHealthCareCovPolicyHolderOutSideCase__c).maybe(:bool)
          end

          # rule(:InsurancePolicyNumber__c) do
          #   if key && value && value.match(/[^a-zA-Z\d-]/)
          #     key.failure(text: "invalid Insurance Policy Number - Special characters cannot be input into the field.",
          #                 error: result.errors.to_h)
          #   end
          # end

          # rule(:InsurancePolicyNumber__c) do
          #   if key && value && value.length > 18
          #     key.failure(text: "invalid Insurance Policy Number - Needs to be less than 18 digits",
          #                 error: result.errors.to_h)
          #   end
          # end
        end
      end
    end
  end
end