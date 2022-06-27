# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for SSP_Member__c
      class SSPMemberC < Dry::Struct # rubocop:disable Metrics/ClassLength
        attribute :Name, Types::String.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :AgeAtFosterCare__c, Types::Integer.optional.meta(omittable: true)
        attribute :AlienNumber__c, Types::String.optional.meta(omittable: true) # RequiredValidator, AlienNumberValidator, MaxStringLengthValidator(9)
        attribute :AlienTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :BenefitTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :BirthDate__c, Types::Date.optional.meta(omittable: true)
        attribute :BlindnessBenefitTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :BlindnessHasEndStageRenalDisease__c, Types::String.optional.meta(omittable: true)
        attribute :BlindnessParentUnableToCareForChild__c, Types::String.optional.meta(omittable: true)
        attribute :BlindnessStatus__c, Types::String.optional.meta(omittable: true)
        attribute :CanBuyCookWithHOH__c, Types::Boolean.optional.meta(omittable: true)
        attribute :CheckingAccountNumber__c, Types::String.optional.meta(omittable: true)
        attribute :CitizenshipNumber__c, Types::String.optional.meta(omittable: true) # RequiredValidator, ImDocumentNumberValidator
        attribute :CitizenShipVerificationCode__c, Types::String.optional.meta(omittable: true)
        attribute :CountryOfIssuanceCode__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :DCId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCMemberHighestEducationLevelDetailsId__c, Types::Integer.optional.meta(omittable: true)
        attribute :ProviderId__c, Types::Integer.optional.meta(omittable: true)
        attribute :ProviderName__c, Types::String.optional.meta(omittable: true)
        attribute :DCMemberLivingArrangementId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCMemberWorkReqExemptionId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCPhysicalAddressId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCMailingAddressId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCPregnancyId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DeathConfirmationCode__c, Types::String.optional.meta(omittable: true)
        attribute :DeathDate__c, Types::Date.optional.meta(omittable: true)
        attribute :DHSComments__c, Types::String.optional.meta(omittable: true)
        attribute :DisabilityStatus__c, Types::String.optional.meta(omittable: true)
        attribute :DivorceDate__c, Types::Date.optional.meta(omittable: true) # RequiredValidator do validation in transform
        attribute :DocumentExpiryDate__c, Types::Date.optional.meta(omittable: true) # RequiredValidator, DateFieldValidator
        attribute :DocumentOtherDescription__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :EligibilityStatementCode__c, Types::String.optional.meta(omittable: true)
        attribute :Email__c, Types::String.optional.meta(omittable: true)
        attribute :EmergencyBeginDate__c, Types::Date.optional.meta(omittable: true)
        attribute :EmergencyEndDate__c, Types::Date.optional.meta(omittable: true)
        attribute :EthnicityCode__c, Types::String.optional.meta(omittable: true)
        attribute :ExpectedReturnDate__c, Types::Date.optional.meta(omittable: true) # PastDateValidator
        attribute :FederalCaseNumber__c, Types::String.optional.meta(omittable: true)
        attribute :FirstName__c, Types::String.meta(omittable: false)
        attribute :FosterStateCode__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :GenderCode__c, Types::String.optional.meta(omittable: true)
        attribute :HasAlimonyExpenseToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasDependentCareExpenseToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasDifferentMailingAddressToggle__c, Types::String.optional.meta(omittable: true) # RequiredValidator coudn't figure out this one
        attribute :HasDisabledExpensesToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasEarnedIncomeFromEmploymentToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasEndStageRenalDiseaseToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasFederalIncarcerationInformation__c, Types::String.optional.meta(omittable: true)
        attribute :HasHouseholdPaidChildSupportToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasLegalImmigrationStatusToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasLifeInsuranceToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasLivedInUsToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasMedicalExpensePartDToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasOwnBankAccountToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasPreArrangedFuneralContractToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasRealEstatePropertyToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasReceivedBenefitsFromOtherStateToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasRecievedHalfMealsFrmInstToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasSelfEmploymentIncomeToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasShelterExpenseToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasTaxDeductionsExpenseToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasUnearnedIncomeToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasUtilityExpenseToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasVehicleToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HighestEducationGraduatedDate__c, Types::Date.optional.meta(omittable: true)
        attribute :HighestEducationLevelCode__c, Types::String.optional.meta(omittable: true)
        attribute :I94Number__c, Types::String.optional.meta(omittable: true) # RequiredValidator, I94NumberValidator, MaxStringLengthValidator(11)
        attribute :IAVTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :ImmigrationDateOfBirth__c, Types::Date.optional.meta(omittable: true)
        attribute :ImmigrationDocumentTypeCode__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :ImmigrationFirstName__c, Types::String.optional.meta(omittable: true) # RequiredValidator, NameIllegalCharsValidator
        attribute :ImmigrationLastName__c, Types::String.meta(omittable: false)
        attribute :ImmigrationMiddleName__c, Types::String.optional.meta(omittable: true)
        attribute :ImmigrationSuffix__c, Types::String.optional.meta(omittable: true)
        attribute :IncarcerationBeginDate__c, Types::Date.optional.meta(omittable: true)
        attribute :IndianTribeCode__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :IndianTribeState__c, Types::String.optional.meta(omittable: true)
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
        attribute :InHomeCareType__c, Types::String.optional.meta(omittable: true)
        attribute :InmateStatusIndicator__c, Types::Boolean.optional.meta(omittable: true)
        attribute :LATypeCode__c, Types::String.meta(omittable: false) # RequiredValidator
        attribute :IsBlindToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsCoverageMonth1__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsCoverageMonth2__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsCoverageMonth3__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsDateOfBirthValidated__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsDateOfDeathValidated__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsDisabledToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsEligibleForIndianHealthServicesToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsFederalRecognizedIndianTribeToggle__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :IsFileCleared__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsFiveYearBar__c, Types::String.optional.meta(omittable: true)
        attribute :IsFiveYearBarMet__c, Types::String.optional.meta(omittable: true)
        attribute :IsFixedAddressToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsHispanicLatinoSpanishToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsImmigrationDetailsMatch__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsIndividualAbleToRideToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsIntendToResideToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsMCICreateUpdateRequired__c, Types::String.optional.meta(omittable: true)
        attribute :IsMigrantOrSeasonalFarmWorkerToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsOnSickLeaveToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsPregnantInLastThreeMonthsToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsPrimaryTextPreferred__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :IsQualifiedNonCitizen__c, Types::String.optional.meta(omittable: true)
        attribute :IsReceivingMedicareBenefitToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsStateMedicaidprogramCode__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :IsTMember__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsToBeReferredToWicToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsUSCitizenToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsUSCitizenValidated__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsVerifiedLawfulPresence__c, Types::String.optional.meta(omittable: true)
        attribute :IsWaitingForDecisionToggle__c, Types::String.optional.meta(omittable: true)
        attribute :LastName__c, Types::String.optional.meta(omittable: true)
        attribute :LifeTimeQuarterQuantity__c, Types::Integer.optional.meta(omittable: true)
        attribute :MaidCardNumber__c, Types::String.optional.meta(omittable: true)
        attribute :MailingCertifiedNoStatIndicator__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalCertifiedNoStatIndicator__c, Types::String.optional.meta(omittable: true)
        attribute :MailingCotVacancyIndicator__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalCotVacancyIndicator__c, Types::String.optional.meta(omittable: true)
        attribute :MailingMailAddrDeliveryCode__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalMailAddrDeliveryCode__c, Types::String.optional.meta(omittable: true)
        attribute :MailingResidentialDeliveryIndicator__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalResidentialDeliveryIndicator__c, Types::String.optional.meta(omittable: true)
        attribute :MCIId__c, Types::String.optional.meta(omittable: true)
        attribute :MiddleInitial__c, Types::String.optional.meta(omittable: true)
        attribute :NationalityCode__c, Types::String.optional.meta(omittable: true)
        attribute :NaturalizationNumber__c, Types::String.optional.meta(omittable: true) # RequiredValidator, ImDocumentNumberValidator
        attribute :NonCitizenClassOfAdmissionCode__c, Types::String.optional.meta(omittable: true)
        attribute :NonCitizenEntryDate__c, Types::Date.optional.meta(omittable: true)
        attribute :NoReasonSSNCode__c, Types::String.optional.meta(omittable: true)
        attribute :NumberOfBirthsExpected__c, Types::Integer.optional.meta(omittable: true) # RequiredValidator, required by db if pregnancy
        attribute :OrganizationName__c, Types::String.optional.meta(omittable: true)
        attribute :ParentUnableToCareForChildToggle__c, Types::String.optional.meta(omittable: true)
        attribute :PassportNumber__c, Types::String.optional.meta(omittable: true) # RequiredValidator, ImDocumentNumberValidator
        attribute :PhysicalAddressLine1__c, Types::String.meta(omittable: false) # RequiredValidator
        attribute :PhysicalAddressLine2__c, Types::String.optional.meta(omittable: true) # AddressLine2Validator
        attribute :PhysicalAddrValidated__c, Types::Boolean.optional.meta(omittable: true)
        attribute :MailingAddrValidated__c, Types::Boolean.optional.meta(omittable: true)
        attribute :PhysicalCity__c, Types::String.meta(omittable: false) # RequiredValidator
        attribute :PhysicalCountyCode__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :PhysicalStateCode__c, Types::String.meta(omittable: false)  # RequiredValidator
        attribute :PhysicalZipCode4__c, Types::String.optional.meta(omittable: true)
        attribute :PhysicalZipCode5__c, Types::String.meta(omittable: false) # RequiredValidator, MaxStringLengthValidator(5)
        attribute :MailingAddressLine1__c, Types::String.optional.meta(omittable: true) # RequiredAddressValidator, AddressLine2Validator
        attribute :MailingAddressLine2__c, Types::String.optional.meta(omittable: true) # AddressLine2Validator
        attribute :MailingCity__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :MailingCountyCode__c, Types::String.optional.meta(omittable: true) # RequiredValidator
        attribute :MailingStateCode__c, Types::String.optional.meta(omittable: true)  # RequiredValidator
        attribute :MailingZipCode4__c, Types::String.optional.meta(omittable: true)
        attribute :MailingZipCode5__c, Types::String.optional.meta(omittable: true) # RequiredValidator, MaxStringLengthValidator(5)
        attribute :PreferredIssuanceMethod__c, Types::String.optional.meta(omittable: true)
        # PreferredNotificationMethodCode__c SelectAtLeast1Validator, PreferredContactMethodValidator PreferredContactEmailValidator,
        # PreferredContactTextValidator, TextMessageOptInValidator
        attribute :PreferredNotificationMethodCode__c, Types::String.meta(omittable: false)
        attribute :PreferredSpokenLanguageCode__c, Types::String.optional.meta(omittable: true)
        attribute :PreferredWrittenLanguageCode__c, Types::String.optional.meta(omittable: true)
        # PregnancyDueDate__c required by db if pregnant, RequiredValidator, PregnancyDueDateValidator,
        # PastDateValidator, PregnancyOverlappingDateValidator
        attribute :PregnancyDueDate__c, Types::Date.optional.meta(omittable: true)
        attribute :PregnancyTerminationDate__c, Types::Date.optional.meta(omittable: true) # RequiredValidator
        attribute :PrimaryPhoneExtension__c, Types::Integer.optional.meta(omittable: true) # MaxStringLengthValidator(10)
        attribute :PrimaryPhoneNumber__c, Types::String.optional.meta(omittable: true) # PhoneNumberValidator
        attribute :PrimaryPhoneTypeCode__c, Types::String.optional.meta(omittable: true) # SamePhoneTypeValidator
        # PrisonerConfinementDate__c required but we don't collect this info!
        attribute :PrisonerConfinementDate__c, Types::Date.optional.meta(omittable: true) # RequiredValidator, FutureDateValidator
        attribute :PseudoSSN__c, Types::String.optional.meta(omittable: true)
        attribute :RaceCode__c, Types::String.optional.meta(omittable: true)
        attribute :ReceiptNumber__c, Types::String.optional.meta(omittable: true) # RequiredValidator, ImmigrationCardNumberValidator
        attribute :ReceivesSSIBenefitsToggle__c, Types::String.optional.meta(omittable: true)
        attribute :RecoveryDate__c, Types::Date.optional.meta(omittable: true)
        attribute :IsAgreeingToLTCResourceTransferConsent__c, Types::String.optional.meta(omittable: true)
        attribute :ReturnToWorkDate__c, Types::Date.optional.meta(omittable: true)
        attribute :RoutingNumber__c, Types::String.optional.meta(omittable: true)
        attribute :SecondaryPhoneExtension__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCAlienSponsorRelationship__c, Types::Integer.optional.meta(omittable: true)
        attribute :SecondaryPhoneNumber__c, Types::String.optional.meta(omittable: true) # PhoneNumberValidator
        attribute :SecondaryPhoneTypeCode__c, Types::String.optional.meta(omittable: true) # SamePhoneTypeValidator
        attribute :IsMilitaryMemberToggle__c, Types::String.optional.meta(omittable: true)
        attribute :SSN__c, Types::String.optional.meta(omittable: true)
        attribute :SSNVerificationCode__c, Types::String.optional.meta(omittable: true)
        attribute :SSNVerificationDate__c, Types::Date.optional.meta(omittable: true)
        attribute :SSNVerified__c, Types::Boolean.optional.meta(omittable: true)
        attribute :SuffixCode__c, Types::String.optional.meta(omittable: true)
        attribute :FederalReserve__c, Types::String.optional.meta(omittable: true)
        attribute :DCInternalAlienSponsorId__c, Types::Integer.optional.meta(omittable: true)
        attribute :HasAlienSponsorToggle__c, Types::String.optional.meta(omittable: true)
        attribute :SpecialNeedIndicatorToggle__c, Types::String.optional.meta(omittable: true)
        attribute :RecordType, RecordType.optional.meta(omittable: true)
        # TaxFilerMemberCurrent__r will have to be validated on transform!
        attribute :TaxFilerMemberCurrent__r, TaxFilerMemberCurrent__r.meta(omittable: false) # RequiredValidator, ClaimantTaxFilingValidator
        # attribute :OrganizationName__r, OrganizationName__r.optional.meta(omittable: true)
        # attribute :TaxFilerMemberNext__r, TaxFilerMemberNext__r.optional.meta(omittable: true)
        # attribute :FederalReserve__r, FederalReserve__r.optional.meta(omittable: true)
        # TaxFilerStatusCurrentYear__c RequiredValidator, TaxFilingWarning, MarkedClaimantWarning
        attribute :TaxFilerStatusCurrentYear__c, Types::String.optional.meta(omittable: true)
        attribute :TaxFilerStatusNextYear__c, Types::String.optional.meta(omittable: true)
        attribute :UnableToBuyCookForSelfToggle__c, Types::String.optional.meta(omittable: true)
        attribute :USCitizenCode__c, Types::String.optional.meta(omittable: true)
        attribute :MatchType__c, Types::String.optional.meta(omittable: true)
        attribute :SevisId__c, Types::String.optional.meta(omittable: true) # RequiredValidator, SEVISIDValidator, MaxStringLengthValidator(10)
        attribute :DeathDateVerificationCode__c, Types::String.optional.meta(omittable: true)
        attribute :IsFosterCareToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasDeathDateChanged__c, Types::String.optional.meta(omittable: true)
        attribute :SponsoredByOrganization__c, Types::String.optional.meta(omittable: true)
        attribute :InternalAlienSponsor__c, Types::String.optional.meta(omittable: true)
        attribute :ExternalAlienSponsor__c, Types::String.optional.meta(omittable: true)
        attribute :HasHouseholdHomeless__c, Types::String.optional.meta(omittable: true)
        attribute :TemporarilyLivesElsewhereToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HospitalizationStartDate__c, Types::Date.optional.meta(omittable: true)
        attribute :HospitalizationEndDate__c, Types::Date.optional.meta(omittable: true)
        attribute :IsRequestingOrReceivingCISToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsReceivingCaretakerServicesToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsNonUSCitizenMilitaryMemberToggle__c, Types::String.optional.meta(omittable: true)
        attribute :Alias_First_Name__c, Types::String.optional.meta(omittable: true)
        attribute :Alias_Last_Name__c, Types::String.optional.meta(omittable: true)
        attribute :LivingArrangementAfterReleaseDate__c, Types::String.meta(omittable: false)
        attribute :MedicareTypeCode__c, Types::String.meta(omittable: false)
        attribute :PregnancyExpectedDueDate__c, Types::Date.optional.meta(omittable: true)
      end
    end
  end
end