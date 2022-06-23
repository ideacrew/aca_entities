# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SspApplicationIndividualCContract, dbclean: :after_each do

  let(:all_params) do
    {
      MemberProgramsApplied__c: "Medicaid",
      IndividualId__c: 12_345,
      SSP_Application__c: "App",
      SSP_Member__c: "Member",
      BlockedCaseNumber__c: "12345",
      SSNRetryFlag__c: false,
      IsApplicationBlocked__c: false,
      Id: "Id",
      MedicaidType__c: "Magi",
      IsHeadOfHousehold__c: true,
      SSP_Member__r: {},
      CISStartDate__c: Date.today,
      CISEndDate__c: Date.today + 1,
      DCCareTakerIntegrationSupplementationId__c: 12_345,
      MentalIllnessImpairsFunctioningToggle__c: "Y",
      MentalIllnessNeedsTreatmentToggle__c: "Y",
      MentalIllnessWithoutAlzheimersToggle__c: "Y",
      IsServiceStoppingInstitutalizationToggle__c: "Y",
      DCCISntegrationSupplementationId__c: 12_345,
      CareCoordinatorName__c: "Full Name",
      CareCoordinatorRelationship__c: "Coordinator",
      CareCoordinatorPhoneNumber__c: "1234567",
      DCCareCoordinatorAddressId__c: 12_345,
      CareCoordinatorAddressLine1__c: "123 Main St",
      CareCoordinatorAddressLine2__c: "n/a",
      CareCoordinatorCity__c: "Atlantis",
      CareCoordinatorStateCode__c: "FL",
      CareCoordinatorZipcode4__c: "1234",
      CareCoordinatorCountyCode__c: "Aroostook",
      CareCoordinatorZipcode5__c: "12345",
      DCCareTakerServiceId__c: 12_345,
      CaretakerName__c: "Caretaker Name",
      CaretakerPhone__c: "1234567",
      CaretakerServiceIndividualId__c: 12_345,
      IsServiceProvidedSafelyToggle__c: "Y",
      IsPreventedNursingFacilityToggle__c: "Y",
      IsServiceReceivedRegularlyToggle__c: "Y",
      ServiceEndDate__c: Date.today + 1,
      ServiceStartDate__c: Date.today,
      CaretakerRelation__c: "Caretaker",
      IsCaretakerLivingTogetherToggle__c: "Y"
    }
  end

  context 'invalid parameters' do
    context 'with incorrect data type' do
      it 'should list error for every bad parameter' do
        bad_params = { MemberProgramsApplied__c: 0 }
        expect(subject.call(bad_params).errors.to_h.keys).to match_array bad_params.keys
      end
    end
  end

  context 'valid parameters' do
    context 'with all required and optional parameters' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end

