# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_ApplicationIndividual__c
        class SspApplicationIndividualCContract < Dry::Validation::Contract
          params do
            optional(:MemberProgramsApplied__c).maybe(:string)
            optional(:IndividualId__c).maybe(:integer)
            optional(:SSP_Application__c).maybe(:string)
            optional(:SSP_Member__c).maybe(:string)
            optional(:BlockedCaseNumber__c).maybe(:string)
            optional(:SSNRetryFlag__c).maybe(:bool)
            optional(:IsApplicationBlocked__c).maybe(:bool)
            optional(:Id).maybe(:string)
            optional(:MedicaidType__c).maybe(:string)
            optional(:IsHeadOfHousehold__c).maybe(:bool)
            optional(:SSP_Member__r).maybe(:hash)
            optional(:CISStartDate__c).maybe(:date)
            optional(:CISEndDate__c).maybe(:date)
            optional(:DCCareTakerIntegrationSupplementationId__c).maybe(:integer)
            optional(:MentalIllnessImpairsFunctioningToggle__c).maybe(:string)
            optional(:MentalIllnessNeedsTreatmentToggle__c).maybe(:string)
            optional(:MentalIllnessWithoutAlzheimersToggle__c).maybe(:string)
            optional(:IsServiceStoppingInstitutalizationToggle__c).maybe(:string)
            optional(:DCCISntegrationSupplementationId__c).maybe(:integer)
            optional(:CareCoordinatorName__c).maybe(:string)
            optional(:CareCoordinatorRelationship__c).maybe(:string)
            optional(:CareCoordinatorPhoneNumber__c).maybe(:string)
            optional(:DCCareCoordinatorAddressId__c).maybe(:integer)
            optional(:CareCoordinatorAddressLine1__c).maybe(:string)
            optional(:CareCoordinatorAddressLine2__c).maybe(:string)
            optional(:CareCoordinatorCity__c).maybe(:string)
            optional(:CareCoordinatorStateCode__c).maybe(:string)
            optional(:CareCoordinatorZipcode4__c).maybe(:string)
            optional(:CareCoordinatorCountyCode__c).maybe(:string)
            optional(:CareCoordinatorZipcode5__c).maybe(:string)
            optional(:DCCareTakerServiceId__c).maybe(:integer)
            optional(:CaretakerName__c).maybe(:string)
            optional(:CaretakerPhone__c).maybe(:string)
            optional(:CaretakerServiceIndividualId__c).maybe(:integer)
            optional(:IsServiceProvidedSafelyToggle__c).maybe(:string)
            optional(:IsPreventedNursingFacilityToggle__c).maybe(:string)
            optional(:IsServiceReceivedRegularlyToggle__c).maybe(:string)
            optional(:ServiceEndDate__c).maybe(:date)
            optional(:ServiceStartDate__c).maybe(:date)
            optional(:CaretakerRelation__c).maybe(:string)
            optional(:IsCaretakerLivingTogetherToggle__c).maybe(:string)
            optional(:MaineCareSubProgram__c).maybe(:string)
            #  optional(:"" Types).maybe()::Boolean.meta(omittable: false)
          end
        end
      end
    end
  end
end