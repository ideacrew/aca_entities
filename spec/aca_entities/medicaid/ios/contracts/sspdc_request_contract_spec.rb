# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SspdcRequestContract, dbclean: :after_each do

  let(:all_params) do
    # commented out fields are from the schema but not expected from us
    {
      SubmitType: "Submit Type", # this should be defaulted to 'Intake'
      SubmittedBy: "Submitted By",
      ApplicationReceivedDateTime: DateTime.now,  # application submission timestamp
      SSP_Application__c: application,
      SSP_Member__c: [{ IndividualId__c: 1 }],
      SSP_Asset__c: [asset],
      SSP_Benefits__c: [benefit],
      # attribute :SSP_Transaction__c, Types::Array.of(SSP_Transaction__c).optional.meta(omittable: true)
      # attribute :SSP_ResourceOwnership__c, Types::Array.of(SSP_ResourceOwnership__c).optional.meta(omittable: true)
      SSP_HealthInsuranceFacilityType__c: [health_insurance_facility_type],
      # attribute :SSP_Attendance__c, Types::Array.of(SSP_Attendance__c).optional.meta(omittable: true)
      SSP_Relationship__c: [relationship],
      SSP_ApplicationIndividual__c: [application_individual],
      SSP_InsurancePolicy__c: [], # Types::Array.of(SSPInsurancePolicyC).optional.meta(omittable: true) # <- no ticket (needs contract, etc)???
      SSP_InsuranceCoveredIndiv__c: [insurance_covered_indiv],
      contact: [contact]
      # attribute :SSP_TrackDeletion__c, Types::Array.of(SSP_TrackDeletion__c).optional.meta(omittable: true)
      # attribute :SSP_NoncustodialRelationship__c, Types::Array.of(SSP_NoncustodialRelationship__c).optional.meta(omittable: true)
      # attribute :SSP_NonCustodialParent__c, Types::Array.of(SSP_NonCustodialParent__c).optional.meta(omittable: true)
      # attribute :accountContactRelation, Types::Array.of(accountContactRelation).optional.meta(omittable: true)
      # attribute :SSP_AlienSponsor__c, Types::Array.of(SSP_AlienSponsor__c).optional.meta(omittable: true)
    }
  end

  let(:application) do
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
      Name: "Name",
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
      NotEnrolledInHealthCareCoverageToggle__c: "Y"
    }
  end

  let(:asset) do
    {
      SSP_Member__c: "Member",
      ProviderName__C: "Provider",
      IsExistingData__c: true,
      IsDeleted__c: false,
      RecordTypeId: "Id",
      Id: "Id",
      AccountBalance__c: 1.00,
      ActivityStartDate__c: Date.today,
      ActivityType__c: "Activity",
      ReceiveInHouseAssistance__c: "N",
      RecordType: {},
      AddressLine1__c: "123 Main St",
      AddressLine2__c: "Apt. 2",
      BooksAmount__c: 1.00,
      BusinessTitle__c: "Business",
      BusinessTypeCode__c: "Code",
      CashSurrenderValue__c: 1.00,
      ChildName__c: "Child Name",
      City__c: "City",
      CountyCode__c: "Aroostok",
      DateOfissuance__c: Date.today,
      DateOwned__c: Date.today,
      DCAddressId__c: 12_345,
      DCEmploymentDetailId__c: 12_345,
      DCExpenseDetailId__c: 12_345,
      DCId__c: 12_345,
      DCResourceValueDetailId__c: 12_345,
      DCResourceMiscellaneousDetailId__c: 12_345,
      DCResourceOwnershipDetailId__c: 12_345,
      DCSelfEmploymentIncomeDetailId__c: 12_345,
      DCUnearnedIncomeDetailId__c: 12_345,
      DependentCareProvider__c: "Dependent Care Provider",
      DependentCareProviderId: 12_345,
      DependentIndividual__c: "Dependent Individual",
      EIN__c: 12_345,
      EmployerName__c: "Employer",
      EmploymentEndReason__c: "Employment Reason",
      EndDate__c: Date.today,
      ExpenseAmount__c: 1.00,
      ExpenseFrequencyCode__c: "Expense Frequency Code",
      ExpenseSubType__c: "Expense Type Code",
      ExpenseTypeCode__c: "Child Support",
      FaceValueAmount__c: 1,
      FeesAmount__c: 1,
      FuneralFundCode__c: "Funeral Code",
      FuneralLocation__c: "Funeral Location",
      HasItemizedStmtOfGoodsSignByClientToggle__c: "Sign By Client Toggle",
      HasPolicyAssignedToFuneralHomeToggle__c: "Funeral Home Toggle",
      IncomePayDetailHoursPerWeek__c: 40,
      IncomePayFrequency__c: "Weekly",
      IncomeTypeCode__c: "Income Code",
      IncomeSubtypeCode__c: "Income Sub Type Code",
      InsuranceCompanyAddress__c: "123 Insurance Lane",
      InsuranceCompanyName__c: "Insurance Co.",
      InsuranceCompanyPhoneNumber__c: "1234567",
      InsurancePolicyAsset__c: "Insurance Policy Asset",
      IsHomeHomesteadPropertyToggle__c: "Property Toggle",
      IsIncomeEssentialToSelfSupportToggle__c: "Self Support Toggle",
      IsMoneyPaidToOutsideToggle__c: "Outside Toggle",
      IsNonHouseHoldMemberPayingExpenseToggle__c: "Expense Toggle",
      IsPolicyDesignatedToPayBurialToggle__c: "Burial Toggle",
      IsPolicyUsedForPrearrangedFuneralToggle__c: "Funeral Toggle",
      IsSchoolDegreeRequiredToggle__c: "Degree Required Toggle",
      IsUnempBenefitsRequiredToggle__c: "Benefits Required Toggle",
      LoanBalance__c: 1.00,
      Location__c: "Location",
      Make__c: "Make",
      MiscellaneousAmount__c: 1.00,
      Model__c: 123,
      ModelYear__c: "2022",
      NoAccessReason__c: "No Access Reason",
      NotEnoughInformation__c: false,
      PolicyNumber__c: "12345",
      PreFuneralAgmtGoodsAndServicesCost__c: 1.00,
      PrimaryPhoneExtension__c: "123",
      PrimaryPhoneNumber__c: "123-456-7890",
      PrimaryUserIndividual__c: "Primary User",
      PrimaryUserIfOther__c: "Primary User If Other",
      RealEstateFairMarketValue__c: 1.00,
      ResourceEndDate__c: Date.today + 1,
      ResourceEndReason__c: "End Reason",
      ResourceSubTypeCode__c: "Resource Sub Type",
      ResourceTypeCode__c: "Resource Type Code",
      StartDate__c: Date.today,
      StateCode__c: "State Code",
      Tips__c: 1.00,
      TotalGrossAmount__c: 1.00,
      TuitionAmount__c: 1.00,
      VehicleCategoryCode__c: "Vehicle Category Code",
      VehicleDebt__c: 1.00,
      VehicleFairMarketValue__c: 1.00,
      VehicleTypeCode__c: "Vehicle Type Code",
      VehicleUseReason__c: "Vehicle Use Reason",
      ZipCode4__c: "1234",
      ZipCode5__c: "12345",
      IndividualId__c: 12_345,
      IsThereAnotherOwnerToggle__c: "Y",
      DCResourceDetailId__c: 12_345
    }
  end

  let(:benefit) do
    {
      BeginDate__c: Date.today, # OverlappingMedicareCoverageValidator <- validate in transform
      SSP_Member__c: "Member",
      Id: "12345",
      BenefitPrograms__c: "Benefits Programs",
      MedicareTypeCode__c: "Medicare Type Code",
      MedicareNumber__c: "MedicareNumber",
      BenefitApplicationDate__c: Date.today,
      BenefitDenialDate__c: Date.today,
      BenefitDenialReason__c: "Benefit Denial Reason",
      BenefitInfoCounty__c: "Benefit Info County",
      BenefitTypeCode__c: "Benefit Type Code",
      DCId__c: 12_345,
      EndDate__c: Date.today, # OverlappingMedicareCoverageValidator <- need to implement? no definnition in spreadsheet
      State__c: "State",
      StatusofApplication__c: "Status of Application",
      HasMedicareCoverageButNoInfo__c: false,
      RecordType: {},
      SSP_Member__r: {}
    }
  end

  let(:health_insurance_facility_type) do
    {
      CoverageStartDate__c: Date.today - 1,
      SSP_InsuranceCoveredIndiv__c: "Insurance Coverd Indiv",
      Id: "12345",
      CoverageEndDate__c: Date.today,
      DCInsuranceCoveredIndivId__c: 12_345,
      DCId__c: 12_345,
      FacilityType__c: "Facility Type",  # SelectAtLeast1Validator <- validate in transform
      EmploymentEndReason__c: "Employment End Reason"  # not on schema RequiredValidator <- need to confirm this field and requirement
    }
  end

  let(:relationship) do
    {
      RelationshipType__c: "tbd",
      SSP_MemberRelatedTo__c: "Related Member",
      SSP_Member__c: "Member",
      DCId__c: 2345,
      Id: "Id",
      IntendToPursueLegalCustodyToggle__c: "false",
      IsActingParentToggle__c: "false",
      IsCareTakerToggle__c: "false",
      IndividualId__c: 1234,
      SSP_Member__r: {}
    }
  end

  let(:application_individual) do
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

  let(:insurance_covered_indiv) do
    {
      DateofBirth__c: Date.today,
      DCId__c: 12_345,
      DCIndividualId__c: 12_345,
      DCMedicaidPolicyIndividualId__c: 12_345,
      ExtAddressLine1__c: "123 Main St",
      ExtAddressLine2__c: "Apt 1",
      ExtCity__c: "Sim City",
      ExtPolicyHolderFirstName__c: "Ex",
      ExtPolicyHolderLastName__c: "PolicyHolder",
      ExtPolicyHolderMiddleInitial__c: "T",  # MaxStringLengthValidator(30)
      ExtPolicyHolderSsn__c: 123_456_789,
      ExtStateCode__c: "State",
      ExtZipCode4__c: "1234",
      ExtZipCode5__c: "12345",
      FirstName__c: "First",
      Gender__c: "F",
      IsEnrolled__c: true,  # SelectAtLeast1CoverageEnrollmentValidator
      IsTobbacoConsumerToggle__c: "N",
      LastName__c: "Last",
      MedicaidId__c: "Medicaid Id",
      RelationshipCode__c: "Relationship",
      SSN__c: "123456789",
      SSP_Member__c: "Member",
      SuffixCode__c: "Suffix",
      IndividualId__c: 12_345,
      SSP_InsurancePolicy__c: "Insurance Policy",
      IsDeleted__c: false,
      IsInsuranceCovered__c: "Y",
      IsPolicyHolder__c: true,
      InsuranceInternalPolicyHolder__c: "Insurance Internal Policy Holder",
      Id: "Id",
      RecordType: {},
      SSP_Member__r: {}
    }
  end

  let(:contact) do
    {
      FirstName: "First",
      LastName: "Last",
      AddressTypeCode__c: "Code",
      AgencyEmployeeId__c: 12_345,
      AssociationStartDate__c: Date.today,
      Birthdate: Date.new(1990, 1, 1),
      Email: "fake@test.com",
      GenderCode__c: "M",
      MailingAddressLine2__c: "Address",
      OrganizationName__c: "Org",
      OrgranizationIdentificationNumber__c: "12345",
      PreferredLanguageCode__c: "EN",
      PrimaryPhoneExtension__c: 123,
      PrimaryPhoneNumber__c: "123-4567",
      RepresentativeProgramCode__c: "Medicaid",
      SSN__c: "123456789",
      SuffixCode__c: "n/a",
      IndividualId__c: "Id",
      Id: "Id",
      MiddleName: "M",
      Phone: "123-4567",
      DCDataId__c: 12_345,
      IsManualAuthRep__c: false,
      RecordType: {},
      AgencyOrOrganization__r: {}
    }
  end

  context 'invalid parameters' do
    context 'with incorrect data type' do
      it 'should list error for every bad parameter' do
        bad_params = { SSP_Member__c: 0 }
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