# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_HealthInsuranceFacilityType__c
        class SspHealthInsuranceFacilityTypeCContract < Dry::Validation::Contract
          params do
            optional(:SSP_InsuranceCoveredIndiv__c).maybe(:string)
            optional(:Id).maybe(:string)
            optional(:CoverageEndDate__c).maybe(:date) # CoverageEndDateAndReasonValidator EndDateStartDateValidator
            required(:CoverageStartDate__c).filled(:date)  # RequiredValidator EndDateStartDateValidator
            optional(:DCInsuranceCoveredIndivId__c).maybe(:integer)
            optional(:DCId__c).maybe(:integer)
            optional(:FacilityType__c).maybe(:string)  # SelectAtLeast1Validator
            optional(:EmploymentEndReason__c).maybe(:string)  # not on schema RequiredValidator
          end

          # rule(:CoverageEndDate__c) do
          #   if key && value
          #     key.failure(text: "invalid coverage end date - "
          #                 error: result.errors.to_h)
          #   end
          # end
        end
      end
    end
  end
end