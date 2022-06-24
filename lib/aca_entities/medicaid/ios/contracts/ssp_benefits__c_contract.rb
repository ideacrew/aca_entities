# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_Benefits__c
        class SspBenefitsCContract < Dry::Validation::Contract
          params do
            optional(:SSP_Member__c).maybe(:string)
            optional(:Id).maybe(:string)
            optional(:BenefitPrograms__c).maybe(:string)
            optional(:MedicareTypeCode__c).maybe(:string)
            optional(:MedicareNumber__c).maybe(:string)
            required(:BeginDate__c).filled(:date)  # OverlappingMedicareCoverageValidator FutureDateValidator RequiredValidator
            optional(:BenefitApplicationDate__c).maybe(:date)
            optional(:BenefitDenialDate__c).maybe(:date)
            optional(:BenefitDenialReason__c).maybe(:string)
            optional(:BenefitInfoCounty__c).maybe(:string)
            optional(:BenefitTypeCode__c).maybe(:string)
            optional(:DCId__c).maybe(:integer)
            optional(:EndDate__c).maybe(:date) # OverlappingMedicareCoverageValidator EndDateStartDateValidator
            optional(:State__c).maybe(:string)
            optional(:StatusofApplication__c).maybe(:string)
            optional(:HasMedicareCoverageButNoInfo__c).maybe(:bool)
            optional(:RecordType).maybe(:hash)
            optional(:SSP_Member__r).maybe(:hash)
          end

          # ADD VALIDATIONS
          # rule(:BeginDate__c) do
          #   if key && value
          #   end
          # end
        end
      end
    end
  end
end