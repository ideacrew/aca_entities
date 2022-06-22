# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for SSP_ApplicationIndividual__c
      class SspApplicationIndividualC < Dry::Struct
        attribute :MemberProgramsApplied__c, Types::String.optional.meta(omittable: true)
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
        attribute :SSP_Application__c, Types::String.optional.meta(omittable: true)
        attribute :SSP_Member__c, Types::String.optional.meta(omittable: true)
        attribute :BlockedCaseNumber__c, Types::String.optional.meta(omittable: true)
        attribute :SSNRetryFlag__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsApplicationBlocked__c, Types::Boolean.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :MedicaidType__c, Types::String.optional.meta(omittable: true)
        attribute :IsHeadOfHousehold__c, Types::Boolean.optional.meta(omittable: true)
        attribute :SSP_Member__r, SSP_Member__r.optional.meta(omittable: true)
        attribute :CISStartDate__c, Types::Date.optional.meta(omittable: true)
        attribute :CISEndDate__c, Types::Date.optional.meta(omittable: true)
        attribute :DCCareTakerIntegrationSupplementationId__c, Types::Integer.optional.meta(omittable: true)
        attribute :MentalIllnessImpairsFunctioningToggle__c, Types::String.optional.meta(omittable: true)
        attribute :MentalIllnessNeedsTreatmentToggle__c, Types::String.optional.meta(omittable: true)
        attribute :MentalIllnessWithoutAlzheimersToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsServiceStoppingInstitutalizationToggle__c, Types::String.optional.meta(omittable: true)
        attribute :DCCISntegrationSupplementationId__c, Types::Integer.optional.meta(omittable: true)
        attribute :CareCoordinatorName__c, Types::String.optional.meta(omittable: true)
        attribute :CareCoordinatorRelationship__c, Types::String.optional.meta(omittable: true)
        attribute :CareCoordinatorPhoneNumber__c, Types::String.optional.meta(omittable: true)
        attribute :DCCareCoordinatorAddressId__c, Types::Integer.optional.meta(omittable: true)
        attribute :CareCoordinatorAddressLine1__c, Types::String.optional.meta(omittable: true)
        attribute :CareCoordinatorAddressLine2__c, Types::String.optional.meta(omittable: true)
        attribute :CareCoordinatorCity__c, Types::String.optional.meta(omittable: true)
        attribute :CareCoordinatorStateCode__c, Types::String.optional.meta(omittable: true)
        attribute :CareCoordinatorZipcode4__c, Types::String.optional.meta(omittable: true)
        attribute :CareCoordinatorCountyCode__c, Types::String.optional.meta(omittable: true)
        attribute :CareCoordinatorZipcode5__c, Types::String.optional.meta(omittable: true)
        attribute :DCCareTakerServiceId__c, Types::Integer.optional.meta(omittable: true)
        attribute :CaretakerName__c, Types::String.optional.meta(omittable: true)
        attribute :CaretakerPhone__c, Types::String.optional.meta(omittable: true)
        attribute :CaretakerServiceIndividualId__c, Types::Integer.optional.meta(omittable: true)
        attribute :IsServiceProvidedSafelyToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsPreventedNursingFacilityToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsServiceReceivedRegularlyToggle__c, Types::String.optional.meta(omittable: true)
        attribute :ServiceEndDate__c, Types::Date.optional.meta(omittable: true)
        attribute :ServiceStartDate__c, Types::Date.optional.meta(omittable: true)
        attribute :CaretakerRelation__c, Types::String.optional.meta(omittable: true)
        attribute :IsCaretakerLivingTogetherToggle__c, Types::String.optional.meta(omittable: true)
        # attribute :"", Types::Boolean.meta(omittable: false)
      end
    end
  end
end