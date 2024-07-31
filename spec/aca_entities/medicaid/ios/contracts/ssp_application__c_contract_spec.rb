# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SspApplicationCContract do
  let(:required_params) do
    {
      NotEnrolledInHealthCareCoverageToggle__c: "Y",
      ApplicationEsignFirstName__c: "John",
      ApplicationEsignLastName__c: "Doe"
    }
  end

  let(:optional_params) do
    {
      ApplicationReceivedDateTime__c: DateTime.now,
      DCsnapHouseholdExpeditedScreeningId__c: 12_345,
      DeclrtnfAnnuitiesAcceptanceCode__c: "Code",
      HasShelterExpExceedIncomeResourcesToggle__c: "Y",
      HouseholdTotalMonthlyCashSavingAmount__c: 1.00,
      HouseholdTotalMonthlyGrossIncAmount__c: 100.00,
      IsApplicantAgreeToWorkRegister__c: "Y",
      IsAssetsInExcess1M__c: false,
      IsDestituteFarmOrMigrantHouseholdToggle__c: "N",
      IsReceivingHousingAssistanceToggle__c: "Y",
      IsRenewalConsent__c: "N",
      Name: "First Last",
      ProgramsApplied__c: "Medicaid",
      Status__c: "Pending",
      DcCaseNumber__c: "12345",
      Id: "Id",
      Account__c: "AccName",
      IsRegisteredToVote__c: "Y",
      Contact__c: "Contact",
      ApplicationId__c: "Id",
      IsApplicantAuthorizedRepresentative__c: "Y",
      IsApplicationSubmittedEarly__c: "N",
      IsRACAddIndividuals__c: "N",
      IsDMSAnnuitiesBeneficiary__c: "N",
      IsFleeingFelonToggle__c: "N",
      IsParticipatingCompltdTreatmentToggle__c: "N",
      IsConvictedChemicallyDependentToggle__c: "Y",
      IsConvictedOfDrugFelonyToggle__c: "Y",
      HasGivenWrongInformationToggle__c: "Y",
      HasConvictedOfBuyingSellingToggle__c: "Y",
      HasConvictedOfTradingFirearm__c: "Y",
      HasConvictedOfTradingDrugsToggle__c: "Y",
      HasAnnuityToggle__c: "Y",
      HasSpecialNeedTrustToggle__c: "Y",
      HasBurialFundToggle__c: "Y",
      HasBurialPlotsToggle__c: "Y",
      HasPromissoryNoteOrLandContractToggle__c: "Y",
      HasOtherResourceToggle__c: "Y",
      HasLifeEstateToggle__c: "Y",
      HasLTCAgreementToggle__c: "Y",
      HasPartnershipQualifiedLTCPolicyToggle__c: "Y",
      HasLifeSettlementContractToggle__c: "Y",
      IsAssetsInExcess1MToggle__c: "Y",
      IsSignedbyAuthorizedRepresentative__c: "Y",
      IsAgreeingToMedicaidPenalty__c: "Y",
      HasPendingAccidentSettlementToggle__c: "Y",
      IsPrimaryApplicantAddressModified__c: false,
      ApplicationEsignMiddleName__c: "Atticus",
      ApplicationEsignSuffixCode__c: "Esq"
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'invalid parameters' do
    context 'with incorrect data type' do
      it 'should list error for every bad parameter' do
        bad_params = {  :ApplicationReceivedDateTime__c => 0,
                        :ApplicationEsignLastName__c => 1,
                        :ApplicationEsignFirstName__c => 1,
                        :NotEnrolledInHealthCareCoverageToggle__c => 1 }
        expect(subject.call(bad_params).errors.to_h.keys).to match_array bad_params.keys
      end
    end
  end

  context 'with optional parameters only' do
    it 'should list error for every required parameter' do
      expect(subject.call(optional_params).errors.to_h.keys).to match_array required_params.keys
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
