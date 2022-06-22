# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for SSP_HealthInsuranceFacilityType__c
      class SSPHealthInsuranceFacilityTypeC < Dry::Struct
        attribute :SSP_InsuranceCoveredIndiv__c, Types::String.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :CoverageEndDate__c, Types::Date.optional.meta(omittable: true) # CoverageEndDateAndReasonValidator, EndDateStartDateValidator
        attribute :CoverageStartDate__c, Types::Date.meta(omittable: false) # RequiredValidator, EndDateStartDateValidator
        attribute :DCInsuranceCoveredIndivId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCId__c, Types::Integer.optional.meta(omittable: true)
        attribute :FacilityType__c, Types::String.optional.meta(omittable: true) # SelectAtLeast1Validator
        attribute :EmploymentEndReason__c, Types::String.optional.meta(omittable: true) # not on schema RequiredValidator
      end
    end
  end
end