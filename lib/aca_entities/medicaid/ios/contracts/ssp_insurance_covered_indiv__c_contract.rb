# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_InsuranceCoveredIndiv__c
        class SspInsuranceCoveredIndivCContract < Dry::Validation::Contract
          params do
            optional(:DateofBirth__c).maybe(:date)
            optional(:DCId__c).maybe(:integer)
            optional(:DCIndividualId__c).maybe(:integer)
            optional(:DCMedicaidPolicyIndividualId__c).maybe(:integer)
            optional(:ExtAddressLine1__c).maybe(:string)
            optional(:ExtAddressLine2__c).maybe(:string)
            optional(:ExtCity__c).maybe(:string)
            optional(:ExtPolicyHolderFirstName__c).maybe(:string)
            optional(:ExtPolicyHolderLastName__c).maybe(:string)
            optional(:ExtPolicyHolderMiddleInitial__c).maybe(:string)
            optional(:ExtPolicyHolderSsn__c).maybe(:integer)
            optional(:ExtStateCode__c).maybe(:string)
            optional(:ExtZipCode4__c).maybe(:string)
            optional(:ExtZipCode5__c).maybe(:string)
            optional(:FirstName__c).maybe(:string)
            optional(:Gender__c).maybe(:string)
            # IsEnrolled__c: SelectAtLeast1CoverageEnrollmentValidator not defined in spreadsheet, need more info to implement
            optional(:IsEnrolled__c).maybe(:bool)
            optional(:IsTobbacoConsumerToggle__c).maybe(:string)
            optional(:LastName__c).maybe(:string)
            optional(:MedicaidId__c).maybe(:string)
            optional(:RelationshipCode__c).maybe(:string)
            optional(:SSN__c).maybe(:string)
            optional(:SSP_Member__c).maybe(:string)
            optional(:SuffixCode__c).maybe(:string)
            optional(:IndividualId__c).maybe(:integer)
            optional(:SSP_InsurancePolicy__c).maybe(:string)
            optional(:IsDeleted__c).maybe(:bool)
            optional(:IsInsuranceCovered__c).maybe(:string)
            optional(:IsPolicyHolder__c).maybe(:bool)
            optional(:InsuranceInternalPolicyHolder__c).maybe(:string)
            optional(:Id).maybe(:string)
            optional(:RecordType).maybe(:hash)
            optional(:SSP_Member__r).maybe(:hash)
          end

          rule(:ExtPolicyHolderMiddleInitial__c) do
            if key && value && value.length > 30
              key.failure(text: "invalid Ext Policy Holder Middle Initial - Only a maximum of 30 characters allowed",
                          error: result.errors.to_h)
            end
          end

        end
      end
    end
  end
end