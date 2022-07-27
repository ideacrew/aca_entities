# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_Benefits__c
        class SspBenefitsCContract < Dry::Validation::Contract
          params do
            required(:BeginDate__c).filled(:date)  # OverlappingMedicareCoverageValidator <- VALIDATE THESE IN TRANSFORM
            optional(:EndDate__c).maybe(:date) # OverlappingMedicareCoverageValidator <- VALIDATE THIS IN TRANSFORM
            optional(:Id).maybe(:string)
            # optional(:BenefitApplicationDate__c).maybe(:date)
            # optional(:BenefitDenialDate__c).maybe(:date)
            # optional(:BenefitDenialReason__c).maybe(:string)
            # optional(:BenefitInfoCounty__c).maybe(:string)
            # optional(:BenefitPrograms__c).maybe(:string)
            # optional(:BenefitTypeCode__c).maybe(:string)
            # optional(:DCId__c).maybe(:integer)
            # optional(:HasMedicareCoverageButNoInfo__c).maybe(:bool)
            # optional(:MedicareNumber__c).maybe(:string)
            # optional(:MedicareTypeCode__c).maybe(:string)
            # optional(:RecordType).maybe(:hash)
            # optional(:SSP_Member__c).maybe(:string)
            # optional(:SSP_Member__r).maybe(:hash)
            # optional(:State__c).maybe(:string)
            # optional(:StatusofApplication__c).maybe(:string)
          end

          rule(:BeginDate__c) do
            if key && value && value > Date.today
              key.failure(text: "invalid Begin Date - Date should be today or in the past.",
                          error: result.errors.to_h)
            end
          end

          rule(:BeginDate__c, :EndDate__c) do
            if key && values[:BeginDate__c] && values[:EndDate__c] && values[:EndDate__c] < values[:BeginDate__c]
              key.failure(text: "invalid End Date - End Date should be later than Begin Date.",
                          error: result.errors.to_h)
            end
          end
        end
      end
    end
  end
end