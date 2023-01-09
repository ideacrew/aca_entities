# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_HealthInsuranceFacilityType__c
        class SspHealthInsuranceFacilityTypeCContract < Dry::Validation::Contract
          params do
            required(:CoverageStartDate__c).filled(:date)
            optional(:SSP_InsuranceCoveredIndiv__c).maybe(:string)
            optional(:Id).maybe(:string)
            optional(:CoverageEndDate__c).maybe(:date)
            # optional(:DCInsuranceCoveredIndivId__c).maybe(:integer)
            # optional(:DCId__c).maybe(:integer)
            optional(:FacilityType__c).maybe(:string) # SelectAtLeast1Validator <- validate in transform
            # optional(:EmploymentEndReason__c).maybe(:string) # not on schema RequiredValidator <- need to confirm this field and requirement
          end

          rule(:CoverageStartDate__c, :CoverageEndDate__c) do
            if key && values[:CoverageStartDate__c] && values[:CoverageEndDate__c] && values[:CoverageEndDate__c] < values[:CoverageStartDate__c]
              key.failure(text: "invalid Coverage End Date - Coverage End Date should be later than Coverage Start Date.",
                          error: result.errors.to_h)
            end
          end
        end
      end
    end
  end
end