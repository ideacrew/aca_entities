# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SSPMemberCContract, dbclean: :after_each do

  let(:required_params) do
    {
      FirstName__c: "Jane",
      LATypeCode__c: "Code",
      PreferredNotificationMethodCode__c: "email",
      TaxFilerMemberCurrent__r: { IndividualId__c: 129 },
      LastName__c: "Doe",
      MemberProgramsApplied__c: "MA",
      IsFederalRecognizedIndianTribeToggle__c: "N",
      IsPregnant__c: "N",
      TaxFilerStatusCurrentYear__c: "S",
      IsFixedAddressToggle__c: "N",
      HasDifferentMailingAddress__c: "N"
    }
  end

  let(:optional_params) do
    {
      Name: "Name",
      Id: "Id",
      AgeAtFosterCare__c: 21,
      AlienNumber__c: "34985783",
      AlienTypeCode__c: "Code",
      BenefitTypeCode__c: "Code",
      BirthDate__c: Date.new(1999, 1, 1),
      BlindnessBenefitTypeCode__c: "Code",
      BlindnessHasEndStageRenalDisease__c: "false",
      BlindnessParentUnableToCareForChild__c: "false",
      BlindnessStatus__c: "false",
      CanBuyCookWithHOH__c: "true",
      CheckingAccountNumber__c: "32498574835748457485",
      CitizenshipNumber__c: "4253453",
      CitizenShipVerificationCode__c: "Code",
      CountryOfIssuanceCode__c: "Code",
      DCId__c: 123,
      DCMemberHighestEducationLevelDetailsId__c: 3,
      ProviderId__c: 485,
      ProviderName__c: "Abott Costello",
      DCMemberLivingArrangementId__c: 12,
      DCMemberWorkReqExemptionId__c: 498,
      DCPhysicalAddressId__c: "123 Main St",
      DCMailingAddressId__c: "123 Main St",
      DCPregnancyId__c: 283,
      DeathConfirmationCode__c: "false",
      DeathDate__c: Date.new(2022, 1, 1),
      DHSComments__c: "look, such comment",
      DisabilityStatus__c: "Status",
      DivorceDate__c: Date.new(2019, 4, 3),
      DocumentExpiryDate__c: Date.new(2025, 4, 5),
      DocumentOtherDescription__c: "what a doc",
      EligibilityStatementCode__c: "Code",
      Email__c: "email@ems.com",
      EmergencyBeginDate__c: Date.new(2021, 1, 1),
      EmergencyEndDate__c: Date.new(2021, 12, 31),
      EthnicityCode__c: "W",
      ExpectedReturnDate__c: Date.today,
      FederalCaseNumber__c: "Cae number",
      FosterStateCode__c: "ME",
      GenderCode__c: "F",
      HasAlimonyExpenseToggle__c: "false",
      HasDependentCareExpenseToggle__c: "true",
      HasDifferentMailingAddressToggle__c: "false",
      HasDisabledExpensesToggle__c: "false",
      HasEarnedIncomeFromEmploymentToggle__c: "false",
      HasEndStageRenalDiseaseToggle__c: "false",
      HasFederalIncarcerationInformation__c: "false",
      HasHouseholdPaidChildSupportToggle__c: "false",
      HasLegalImmigrationStatusToggle__c: "true",
      HasLifeInsuranceToggle__c: "false",
      HasLivedInUsToggle__c: "true",
      HasMedicalExpensePartDToggle__c: "false",
      HasOwnBankAccountToggle__c: "true",
      HasPreArrangedFuneralContractToggle__c: "false",
      HasRealEstatePropertyToggle__c: "false",
      HasReceivedBenefitsFromOtherStateToggle__c: "false",
      HasRecievedHalfMealsFrmInstToggle__c: "false",
      HasSelfEmploymentIncomeToggle__c: "false",
      HasShelterExpenseToggle__c: "false",
      HasTaxDeductionsExpenseToggle__c: "false",
      HasUnearnedIncomeToggle__c: "false",
      HasUtilityExpenseToggle__c: "false",
      HasVehicleToggle__c: "true",
      HighestEducationGraduatedDate__c: Date.new(2004, 6, 6),
      HighestEducationLevelCode__c: "Code",
      I94Number__c: "111111111A1",
      IAVTypeCode__c: "Code",
      ImmigrationLastName__c: "Doedoe",
      ImmigrationDateOfBirth__c: Date.new(1989, 9, 8),
      ImmigrationDocumentTypeCode__c: "Code",
      ImmigrationFirstName__c: "Jane",
      ImmigrationMiddleName__c: "II",
      ImmigrationSuffix__c: "MD",
      IncarcerationBeginDate__c: Date.new(2019, 1, 4),
      IndianTribeCode__c: "HO",
      IndianTribeState__c: "ME",
      IndividualId__c: 854,
      InHomeCareType__c: "false",
      InmateStatusIndicator__c: "false",
      IsBlindToggle__c: "false",
      IsCoverageMonth1__c: false,
      IsCoverageMonth2__c: false,
      IsCoverageMonth3__c: false,
      IsDateOfBirthValidated__c: true,
      IsDateOfDeathValidated__c: false,
      IsDisabledToggle__c: "false",
      IsEligibleForIndianHealthServicesToggle__c: "true",
      IsFileCleared__c: "false",
      IsFiveYearBar__c: "false",
      IsFiveYearBarMet__c: "false",
      IsHispanicLatinoSpanishToggle__c: "false",
      IsImmigrationDetailsMatch__c: "true",
      IsIndividualAbleToRideToggle__c: "true",
      IsIntendToResideToggle__c: "false",
      IsMCICreateUpdateRequired__c: "false",
      IsMigrantOrSeasonalFarmWorkerToggle__c: "false",
      IsOnSickLeaveToggle__c: "false",
      IsPregnantInLastThreeMonthsToggle__c: "false",
      IsPrimaryTextPreferred__c: "false",
      IsQualifiedNonCitizen__c: "false",
      IsReceivingMedicareBenefitToggle__c: "false",
      IsStateMedicaidprogramCode__c: "Cpde",
      IsTMember__c: "false",
      IsToBeReferredToWicToggle__c: "false",
      IsUSCitizenToggle__c: "N",
      IsUSCitizenValidated__c: "true",
      IsVerifiedLawfulPresence__c: "true",
      IsWaitingForDecisionToggle__c: "false",
      LifeTimeQuarterQuantity__c: 3,
      MaidCardNumber__c: "Card Number",
      MailingCertifiedNoStatIndicator__c: "true",
      PhysicalAddressLine1__c: "1 Main St",
      PhysicalCity__c: "Atlantis",
      PhysicalStateCode__c: "CA",
      PhysicalZipCode5__c: "12901",
      PhysicalCertifiedNoStatIndicator__c: "true",
      MailingCotVacancyIndicator__c: "false",
      PhysicalCotVacancyIndicator__c: "false",
      MailingMailAddrDeliveryCode__c: "Code",
      PhysicalMailAddrDeliveryCode__c: "Code",
      MailingResidentialDeliveryIndicator__c: "true",
      PhysicalResidentialDeliveryIndicator__c: "true",
      MCIId__c: "Id",
      MiddleInitial__c: "O",
      NationalityCode__c: "Code",
      NaturalizationNumber__c: "123456",
      NonCitizenClassOfAdmissionCode__c: "Code",
      NonCitizenEntryDate__c: Date.new(1994, 7, 1),
      NoReasonSSNCode__c: "Reason",
      NumberOfBirthsExpected__c: 1,
      OrganizationName__c: "Org",
      ParentUnableToCareForChildToggle__c: "false",
      PassportNumber__c: "4589678",
      PhysicalAddressLine2__c: "Apt #54",
      PhysicalAddrValidated__c: "false",
      MailingAddrValidated__c: "false",
      PhysicalCountyCode__c: "Code",
      PhysicalZipCode4__c: "4567",
      MailingAddressLine1__c: "123 Main St",
      MailingAddressLine2__c: "Apt #54",
      MailingCity__c: "Atlantis",
      MailingCountyCode__c: "Code",
      MailingStateCode__c: "ME",
      MailingZipCode4__c: "4567",
      MailingZipCode5__c: "12901",
      PreferredIssuanceMethod__c: "Method",
      PreferredSpokenLanguageCode__c: "EN",
      PreferredWrittenLanguageCode__c: "EN",
      PregnancyDueDate__c: Date.today + 100,
      PregnancyTerminationDate__c: Date.today,
      PrimaryPhoneExtension__c: 123,
      PrimaryPhoneNumber__c: "347-657-4567",
      PrimaryPhoneTypeCode__c: "T",
      PrisonerConfinementDate__c: Date.today,
      PseudoSSN__c: "999999999",
      RaceCode__c: "Code",
      ReceiptNumber__c: "abc1234567890",
      ReceivesSSIBenefitsToggle__c: "false",
      RecoveryDate__c: Date.today,
      IsAgreeingToLTCResourceTransferConsent__c: "true",
      ReturnToWorkDate__c: Date.today,
      RoutingNumber__c: "348574857345",
      SecondaryPhoneExtension__c: 456,
      DCAlienSponsorRelationship__c: 897,
      SecondaryPhoneNumber__c: "123-456-7890",
      SecondaryPhoneTypeCode__c: "H",
      IsMilitaryMemberToggle__c: "false",
      SSN__c: "999999999",
      SSNVerificationCode__c: "Code",
      SSNVerificationDate__c: Date.today,
      SSNVerified__c: true,
      SuffixCode__c: "ESQ",
      FederalReserve__c: "Reserve",
      DCInternalAlienSponsorId__c: 872,
      HasAlienSponsorToggle__c: "false",
      SpecialNeedIndicatorToggle__c: "false",
      RecordType: {},
      TaxFilerStatusNextYear__c: "Married",
      UnableToBuyCookForSelfToggle__c: "false",
      USCitizenCode__c: "Code",
      MatchType__c: "Type",
      SevisId__c: "32786473",
      DeathDateVerificationCode__c: "Code",
      IsFosterCareToggle__c: "false",
      HasDeathDateChanged__c: "false",
      SponsoredByOrganization__c: "Org",
      InternalAlienSponsor__c: "Org",
      ExternalAlienSponsor__c: "Org",
      HasHouseholdHomeless__c: "false",
      TemporarilyLivesElsewhereToggle__c: "false",
      HospitalizationStartDate__c: Date.today,
      HospitalizationEndDate__c: Date.today,
      IsRequestingOrReceivingCISToggle__c: "false",
      IsReceivingCaretakerServicesToggle__c: "false",
      IsNonUSCitizenMilitaryMemberToggle__c: "false",
      Alias_First_Name__c: "Jason",
      Alias_Last_Name__c: "Bourne",
      PregnancyExpectedDueDate__c: Date.today,
      LivingArrangementAfterReleaseDate__c: "Home",
      MedicareTypeCode__c: "Code"
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect(subject.call(optional_params).errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'invalid alien number' do
      context 'with invalid characters' do
        it 'should fail validation' do
          all_params[:AlienNumber__c] = '!34_7#'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with invalid length' do
        it 'should fail validation' do
          all_params[:AlienNumber__c] = '4569999997890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with all 0s' do
        it 'should fail validation' do
          all_params[:AlienNumber__c] = '00000000'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid sevis number' do
      context 'with invalid characters' do
        it 'should fail validation' do
          all_params[:SevisId__c] = '!34_7#'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with invalid length' do
        it 'should fail validation' do
          all_params[:SevisId__c] = '4569999997890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with all 0s' do
        it 'should fail validation' do
          all_params[:SevisId__c] = '00000000'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid I94 number' do
      context 'with invalid format' do
        it 'should fail validation' do
          all_params[:I94Number__c] = '123456789A1aa'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with all 0s' do
        it 'should fail validation' do
          all_params[:I94Number__c] = '00000000'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid citizenship number' do
      context 'with invalid characters' do
        it 'should fail validation' do
          all_params[:CitizenshipNumber__c] = '!34_7#'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with invalid length' do
        it 'should fail validation if it is too long' do
          all_params[:CitizenshipNumber__c] = '1234567891234'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end

        it 'should fail validation if it is too short' do
          all_params[:CitizenshipNumber__c] = '45555'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with all 0s' do
        it 'should fail validation' do
          all_params[:CitizenshipNumber__c] = '00000000'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid naturalization number' do
      context 'with invalid characters' do
        it 'should fail validation' do
          all_params[:NaturalizationNumber__c] = '!34_7#'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with invalid length' do
        it 'should fail validation if it is too long' do
          all_params[:NaturalizationNumber__c] = '1234567891234'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end

        it 'should fail validation if it is too short' do
          all_params[:NaturalizationNumber__c] = '45555'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with all 0s' do
        it 'should fail validation' do
          all_params[:NaturalizationNumber__c] = '00000000'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid passport number' do
      context 'with invalid characters' do
        it 'should fail validation' do
          all_params[:PassportNumber__c] = '!34_7#'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with invalid length' do
        it 'should fail validation if it is too long' do
          all_params[:PassportNumber__c] = '1234567891234'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end

        it 'should fail validation if it is too short' do
          all_params[:PassportNumber__c] = '45555'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with all 0s' do
        it 'should fail validation' do
          all_params[:PassportNumber__c] = '00000000'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid expected return date' do
      context 'with past date in the future' do
        it 'should fail validation' do
          all_params[:ExpectedReturnDate__c] = Date.today - 1
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'with invalid address line 2 characters' do
      it 'should list fail validation for mailing address' do
        all_params[:MailingAddressLine2__c] = "Address!"
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end

      it 'should list fail validation for physical address' do
        all_params[:PhysicalAddressLine2__c] = "Address!"
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'with too many zip code characters' do
      it 'should list fail validation for physical address' do
        all_params[:PhysicalZipCode5__c] = "00000-0000"
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end

      it 'should list fail validation for mailing address' do
        all_params[:MailingZipCode5__c] = "00000-0000"
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'with invalid preferred notification method' do
      it 'should list fail validation email if no email' do
        all_params[:PreferredNotificationMethodCode__c] = "Electronic - Email"
        all_params[:Email__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end

      it 'should list fail validation for text if no mobile number' do
        all_params[:PreferredNotificationMethodCode__c] = "Electronic - Text Message"
        all_params[:IsPrimaryTextPreferred__c].nil?
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end

      it 'should list fail validation for text if did not allow for sending texts' do
        all_params[:PreferredNotificationMethodCode__c] = "Electronic - Text Message"
        all_params[:IsPrimaryTextPreferred__c] = "N"
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'invalid pregnancy due date date' do
      context 'with date more than 9 months in the future' do
        it 'should fail validation' do
          all_params[:PregnancyDueDate__c] = Date.today + 400
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid phone extension' do
      context 'with invalid length' do
        it 'should fail validation if it is too long' do
          all_params[:PrimaryPhoneExtension__c] = 123_456_789_123_456_789
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid phone number' do
      context 'primary phone number with invalid characters' do
        it 'should fail validation' do
          all_params[:PrimaryPhoneNumber__c] = '!23-4S6-7890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'primary phone number with invalid length' do
        it 'should fail validation' do
          all_params[:PrimaryPhoneNumber__c] = '456-7890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'primary phone number with invalid format' do
        it 'should fail validation' do
          all_params[:PrimaryPhoneNumber__c] = '1234567890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'secondary phone number with invalid characters' do
        it 'should fail validation' do
          all_params[:SecondaryPhoneNumber__c] = '!23-4S6-7890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'secondary phone number with invalid length' do
        it 'should fail validation' do
          all_params[:SecondaryPhoneNumber__c] = '456-7890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'secondary phone number with invalid format' do
        it 'should fail validation' do
          all_params[:SecondaryPhoneNumber__c] = '1234567890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with the primary phone type having the same value as the secondary phone type' do
        it 'should fail validation' do
          all_params[:SecondaryPhoneTypeCode__c] = 'M'
          all_params[:PrimaryPhoneTypeCode__c] = 'M'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid prisoner confinement date' do
      context 'with date not be in the past' do
        it 'should fail validation' do
          all_params[:PrisonerConfinementDate__c] = Date.today + 400
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'missing Immigration Document Type' do
      context 'for non US citizen' do
        it 'should fail validation' do
          all_params[:IsUSCitizenToggle__c] = 'N'
          all_params[:ImmigrationDocumentTypeCode__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'missing Alien Number' do
      context 'for non US citizen with a document type of I-551 (Permanent Resident Card)'
      it 'should fail validation' do
        all_params[:ImmigrationDocumentTypeCode__c] = "I-551 (Permanent Resident Card)"
        all_params[:AlienNumber__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing Citizenship Number' do
      context 'for non US citizen with a document type of Certificate of Citizenship in non-US country'
      it 'should fail validation' do
        all_params[:ImmigrationDocumentTypeCode__c] = "Certificate of Citizenship in non-US country"
        all_params[:CitizenshipNumber__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing country of issuance code' do
      context 'for non US citizen with a document type of I-94 (Arrival/Departure Record) in Unexpired Foreign Passport'
      it 'should fail validation' do
        all_params[:ImmigrationDocumentTypeCode__c] = "I-94 (Arrival/Departure Record) in Unexpired Foreign Passport"
        all_params[:CountryOfIssuanceCode__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing document expiry date' do
      context 'for non US citizen with a document type of I-94 (Arrival/Departure Record) in Unexpired Foreign Passport'
      it 'should fail validation' do
        all_params[:ImmigrationDocumentTypeCode__c] = "I-94 (Arrival/Departure Record) in Unexpired Foreign Passport"
        all_params[:DocumentExpiryDate__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing I-94 number' do
      context 'for non US citizen with a document type of I-94 (Arrival/Departure Record) in Unexpired Foreign Passport'
      it 'should fail validation' do
        all_params[:ImmigrationDocumentTypeCode__c] = "I-94 (Arrival/Departure Record) in Unexpired Foreign Passport"
        all_params[:I94Number__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing document other description' do
      context 'for Cuban/Haitian entrant'
      it 'should fail validation' do
        all_params[:ImmigrationDocumentTypeCode__c] = "Cuban/Haitian entrant"
        all_params[:DocumentOtherDescription__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing naturalization number' do
      context 'for Naturalization Certificate'
      it 'should fail validation' do
        all_params[:ImmigrationDocumentTypeCode__c] = "Naturalization Certificate"
        all_params[:NaturalizationNumber__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing sevis id' do
      context 'for DS2019'
      it 'should fail validation' do
        all_params[:ImmigrationDocumentTypeCode__c] = "DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)"
        all_params[:SevisId__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing receipt number' do
      context 'for I-551'
      it 'should fail validation' do
        all_params[:ImmigrationDocumentTypeCode__c] = "I-551 (Permanent Resident Card)"
        all_params[:ReceiptNumber__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing passport number' do
      context 'for I-94'
      it 'should fail validation' do
        all_params[:ImmigrationDocumentTypeCode__c] = "I-94 (Arrival/Departure Record) in Unexpired Foreign Passport"
        all_params[:PassportNumber__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing foster state code' do
      context 'for former foster care'
      it 'should fail validation' do
        all_params[:IsFosterCareToggle__c] = "Y"
        all_params[:FosterStateCode__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing medicaid program code' do
      context 'for former foster care'
      it 'should fail validation' do
        all_params[:IsFosterCareToggle__c] = "Y"
        all_params[:IsStateMedicaidprogramCode__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'missing indian tribe code' do
      context 'for member of tribe'
      it 'should fail validation' do
        all_params[:IsFederalRecognizedIndianTribeToggle__c] = "Y"
        all_params[:IndianTribeCode__c] = nil
        result = subject.call(all_params)
        expect(result.success?).to be_falsey
      end
    end

    context 'when pregnant' do
      context 'missing expected number of births' do
        it 'should fail validation' do
          all_params[:IsPregnant__c] = "Y"
          all_params[:NumberOfBirthsExpected__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
      context 'missing due date' do
        it 'should fail validation' do
          all_params[:IsPregnant__c] = "Y"
          all_params[:PregnancyDueDate__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid receipt number' do
      context 'with invalid characters' do
        it 'should fail validation' do
          all_params[:ReceiptNumber__c] = 'ab!234S67890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with invalid length' do
        it 'should fail validation' do
          all_params[:ReceiptNumber__c] = 'abc4567890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with invalid format' do
        it 'should fail validation' do
          all_params[:ReceiptNumber__c] = '1234567890abc'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid physical address' do
      before { all_params[:IsFixedAddressToggle__c] = "Y" }
      context 'with no address line 1' do
        it 'should fail validation' do
          all_params[:PhysicalAddressLine1__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with no city' do
        it 'should fail validation' do
          all_params[:PhysicalCity__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with no state' do
        it 'should fail validation' do
          all_params[:PhysicalStateCode__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with no zip' do
        it 'should fail validation' do
          all_params[:PhysicalZipCode5__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid mailing address' do
      before { all_params[:HasDifferentMailingAddress__c] = "Y" }
      context 'with no address line 1' do
        it 'should fail validation' do
          all_params[:MailingAddressLine1__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with no city' do
        it 'should fail validation' do
          all_params[:MailingCity__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with no state' do
        it 'should fail validation' do
          all_params[:MailingStateCode__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with no zip' do
        it 'should fail validation' do
          all_params[:MailingZipCode5__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

  end



  context 'valid parameters' do
    context 'with required parameters only' do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
    end

    context 'with all required and optional parameters' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end