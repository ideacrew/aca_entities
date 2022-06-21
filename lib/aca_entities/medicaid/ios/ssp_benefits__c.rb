# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module IOS
      # entity for SSP_Benefits__c
      class SSP_Benefits__c < Dry::Struct
        attribute :SSP_Member__c, Types::String.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :BenefitPrograms__c, Types::String.optional.meta(omittable: true)
        attribute :MedicareTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :MedicareNumber__c, Types::String.optional.meta(omittable: true)
        attribute :BeginDate__c, Types::Date.meta(omittable: false) # OverlappingMedicareCoverageValidator, FutureDateValidator, RequiredValidator
        attribute :BenefitApplicationDate__c, Types::Date.optional.meta(omittable: true)
        attribute :BenefitDenialDate__c, Types::Date.optional.meta(omittable: true)
        attribute :BenefitDenialReason__c, Types::String.optional.meta(omittable: true)
        attribute :BenefitInfoCounty__c, Types::String.optional.meta(omittable: true)
        attribute :BenefitTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :DCId__c, Types::Integer.optional.meta(omittable: true)
        attribute :EndDate__c, Types::Date.optional.meta(omittable: true) # OverlappingMedicareCoverageValidator, EndDateStartDateValidator
        attribute :State__c, Types::String.optional.meta(omittable: true)
        attribute :StatusofApplication__c, Types::String.optional.meta(omittable: true)
        attribute :HasMedicareCoverageButNoInfo__c, Types::Boolean.optional.meta(omittable: true)
        attribute :RecordType, RecordType.optional.meta(omittable: true)
        attribute :SSP_Member__r, SSP_Member__r.optional.meta(omittable: true)
      end
    end
  end
end