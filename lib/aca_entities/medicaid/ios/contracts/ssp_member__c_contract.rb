# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_Member__c
        class SspMemberCContract < Dry::Validation::Contract
          params do
            required(:FirstName__c).filled(:string)
            required(:HasDifferentMailingAddress__c).filled(:string)
            required(:IsFederalRecognizedIndianTribeToggle__c).filled(:string)
            required(:IsFixedAddressToggle__c).filled(:string)
            required(:IsPregnant__c).filled(:string)
            required(:LastName__c).filled(:string)
            required(:LATypeCode__c).filled(:string)
            required(:MemberProgramsApplied__c).filled(:string)
            required(:PreferredNotificationMethodCode__c).filled(:string)
            required(:TaxFilerMemberCurrent__r).filled(:hash)
            required(:TaxFilerStatusCurrentYear__c).filled(:string)

            optional(:AgeAtFosterCare__c).maybe(:integer)
            optional(:Alias_First_Name__c).maybe(:string)
            optional(:Alias_Last_Name__c).maybe(:string)
            optional(:AlienNumber__c).maybe(:string)
            optional(:AlienTypeCode__c).maybe(:string)
            optional(:BenefitTypeCode__c).maybe(:string)
            optional(:BirthDate__c).maybe(:date)
            optional(:BlindnessBenefitTypeCode__c).maybe(:string)
            optional(:BlindnessHasEndStageRenalDisease__c).maybe(:string)
            optional(:BlindnessParentUnableToCareForChild__c).maybe(:string)
            optional(:BlindnessStatus__c).maybe(:string)
            optional(:CanBuyCookWithHOH__c).maybe(:string)
            optional(:CheckingAccountNumber__c).maybe(:string)
            optional(:CitizenshipNumber__c).maybe(:string)
            optional(:CitizenShipVerificationCode__c).maybe(:string)
            optional(:CountryOfIssuanceCode__c).maybe(:string)
            optional(:DCAlienSponsorRelationship__c).maybe(:integer)
            optional(:DCId__c).maybe(:integer)
            optional(:DCInternalAlienSponsorId__c).maybe(:integer)
            optional(:DCMailingAddressId__c).maybe(:string)
            optional(:DCMemberHighestEducationLevelDetailsId__c).maybe(:integer)
            optional(:DCMemberLivingArrangementId__c).maybe(:integer)
            optional(:DCMemberWorkReqExemptionId__c).maybe(:integer)
            optional(:DCPhysicalAddressId__c).maybe(:string)
            optional(:DCPregnancyId__c).maybe(:integer)
            optional(:DeathConfirmationCode__c).maybe(:string)
            optional(:DeathDate__c).maybe(:date)
            optional(:DeathDateVerificationCode__c).maybe(:string)
            optional(:DHSComments__c).maybe(:string)
            optional(:DisabilityStatus__c).maybe(:string)
            optional(:DivorceDate__c).maybe(:date)
            optional(:DocumentExpiryDate__c).maybe(:date)
            optional(:DocumentOtherDescription__c).maybe(:string)
            optional(:EligibilityStatementCode__c).maybe(:string)
            optional(:Email__c).maybe(:string)
            optional(:EmergencyBeginDate__c).maybe(:date)
            optional(:EmergencyEndDate__c).maybe(:date)
            optional(:EthnicityCode__c).maybe(:string)
            optional(:ExpectedReturnDate__c).maybe(:date)
            optional(:ExternalAlienSponsor__c).maybe(:string)
            optional(:FederalCaseNumber__c).maybe(:string)
            optional(:FederalReserve__c).maybe(:string)
            optional(:FosterStateCode__c).maybe(:string)
            optional(:GenderCode__c).maybe(:string)
            optional(:HasAlienSponsorToggle__c).maybe(:string)
            optional(:HasAlimonyExpenseToggle__c).maybe(:string)
            optional(:HasDeathDateChanged__c).maybe(:string)
            optional(:HasDependentCareExpenseToggle__c).maybe(:string)
            optional(:HasDifferentMailingAddressToggle__c).maybe(:string)
            optional(:HasDisabledExpensesToggle__c).maybe(:string)
            optional(:HasEarnedIncomeFromEmploymentToggle__c).maybe(:string)
            optional(:HasEndStageRenalDiseaseToggle__c).maybe(:string)
            optional(:HasFederalIncarcerationInformation__c).maybe(:string)
            optional(:HasHouseholdHomeless__c).maybe(:string)
            optional(:HasHouseholdPaidChildSupportToggle__c).maybe(:string)
            optional(:HasLegalImmigrationStatusToggle__c).maybe(:string)
            optional(:HasLifeInsuranceToggle__c).maybe(:string)
            optional(:HasLivedInUsToggle__c).maybe(:string)
            optional(:HasMedicalExpensePartDToggle__c).maybe(:string)
            optional(:HasOwnBankAccountToggle__c).maybe(:string)
            optional(:HasPreArrangedFuneralContractToggle__c).maybe(:string)
            optional(:HasRealEstatePropertyToggle__c).maybe(:string)
            optional(:HasReceivedBenefitsFromOtherStateToggle__c).maybe(:string)
            optional(:HasRecievedHalfMealsFrmInstToggle__c).maybe(:string)
            optional(:HasSelfEmploymentIncomeToggle__c).maybe(:string)
            optional(:HasShelterExpenseToggle__c).maybe(:string)
            optional(:HasTaxDeductionsExpenseToggle__c).maybe(:string)
            optional(:HasUnearnedIncomeToggle__c).maybe(:string)
            optional(:HasUtilityExpenseToggle__c).maybe(:string)
            optional(:HasVehicleToggle__c).maybe(:string)
            optional(:HighestEducationGraduatedDate__c).maybe(:date)
            optional(:HighestEducationLevelCode__c).maybe(:string)
            optional(:HospitalizationEndDate__c).maybe(:date)
            optional(:HospitalizationStartDate__c).maybe(:date)
            optional(:I94Number__c).maybe(:string)
            optional(:IAVTypeCode__c).maybe(:string)
            optional(:Id).maybe(:string)
            optional(:ImmigrationDateOfBirth__c).maybe(:date)
            optional(:ImmigrationDocumentTypeCode__c).maybe(:string)
            optional(:ImmigrationFirstName__c).maybe(:string)
            optional(:ImmigrationLastName__c).maybe(:string)
            optional(:ImmigrationMiddleName__c).maybe(:string)
            optional(:ImmigrationSuffix__c).maybe(:string)
            optional(:IncarcerationBeginDate__c).maybe(:date)
            optional(:IndianTribeCode__c).maybe(:string)
            optional(:IndianTribeState__c).maybe(:string)
            optional(:IndividualId__c).maybe(:integer)
            optional(:InHomeCareType__c).maybe(:string)
            optional(:InmateStatusIndicator__c).maybe(:string)
            optional(:InternalAlienSponsor__c).maybe(:string)
            optional(:IsAgreeingToLTCResourceTransferConsent__c).maybe(:string)
            optional(:IsBlindToggle__c).maybe(:string)
            optional(:IsCoverageMonth1__c).maybe(:bool)
            optional(:IsCoverageMonth2__c).maybe(:bool)
            optional(:IsCoverageMonth3__c).maybe(:bool)
            optional(:IsDateOfBirthValidated__c).maybe(:bool)
            optional(:IsDateOfDeathValidated__c).maybe(:bool)
            optional(:IsDisabledToggle__c).maybe(:string)
            optional(:IsEligibleForIndianHealthServicesToggle__c).maybe(:string)
            optional(:IsFileCleared__c).maybe(:string)
            optional(:IsFiveYearBar__c).maybe(:string)
            optional(:IsFiveYearBarMet__c).maybe(:string)
            optional(:IsFosterCareToggle__c).maybe(:string)
            optional(:IsHispanicLatinoSpanishToggle__c).maybe(:string)
            optional(:IsImmigrationDetailsMatch__c).maybe(:string)
            optional(:IsIndividualAbleToRideToggle__c).maybe(:string)
            optional(:IsIntendToResideToggle__c).maybe(:string)
            optional(:IsMCICreateUpdateRequired__c).maybe(:string)
            optional(:IsMigrantOrSeasonalFarmWorkerToggle__c).maybe(:string)
            optional(:IsMilitaryMemberToggle__c).maybe(:string)
            optional(:IsNonUSCitizenMilitaryMemberToggle__c).maybe(:string)
            optional(:IsOnSickLeaveToggle__c).maybe(:string)
            optional(:IsPregnantInLastThreeMonthsToggle__c).maybe(:string)
            optional(:IsPrimaryTextPreferred__c).maybe(:string)
            optional(:IsQualifiedNonCitizen__c).maybe(:string)
            optional(:IsReceivingCaretakerServicesToggle__c).maybe(:string)
            optional(:IsReceivingMedicareBenefitToggle__c).maybe(:string)
            optional(:IsRequestingOrReceivingCISToggle__c).maybe(:string)
            optional(:IsStateMedicaidprogramCode__c).maybe(:string)
            optional(:IsTMember__c).maybe(:string)
            optional(:IsToBeReferredToWicToggle__c).maybe(:string)
            optional(:IsUSCitizenToggle__c).maybe(:string)
            optional(:IsUSCitizenValidated__c).maybe(:string)
            optional(:IsVerifiedLawfulPresence__c).maybe(:string)
            optional(:IsWaitingForDecisionToggle__c).maybe(:string)
            optional(:LifeTimeQuarterQuantity__c).maybe(:integer)
            optional(:LivingArrangementAfterReleaseDate__c).maybe(:string)
            optional(:MaidCardNumber__c).maybe(:string)
            optional(:MailingAddressLine1__c).maybe(:string)
            optional(:MailingAddressLine2__c).maybe(:string)
            optional(:MailingAddrValidated__c).maybe(:string)
            optional(:MailingCertifiedNoStatIndicator__c).maybe(:string)
            optional(:MailingCity__c).maybe(:string)
            optional(:MailingCotVacancyIndicator__c).maybe(:string)
            optional(:MailingCountyCode__c).maybe(:string)
            optional(:MailingMailAddrDeliveryCode__c).maybe(:string)
            optional(:MailingResidentialDeliveryIndicator__c).maybe(:string)
            optional(:MailingStateCode__c).maybe(:string)
            optional(:MailingZipCode4__c).maybe(:string)
            optional(:MailingZipCode5__c).maybe(:string)
            optional(:MatchType__c).maybe(:string)
            optional(:MCIId__c).maybe(:string)
            optional(:MedicareTypeCode__c).maybe(:string)
            optional(:MiddleInitial__c).maybe(:string)
            optional(:Name).maybe(:string)
            optional(:NationalityCode__c).maybe(:string)
            optional(:NaturalizationNumber__c).maybe(:string)
            optional(:NonCitizenClassOfAdmissionCode__c).maybe(:string)
            optional(:NonCitizenEntryDate__c).maybe(:date)
            optional(:NoReasonSSNCode__c).maybe(:string)
            optional(:NumberOfBirthsExpected__c).maybe(:integer)
            optional(:OrganizationName__c).maybe(:string)
            optional(:ParentUnableToCareForChildToggle__c).maybe(:string)
            optional(:PassportNumber__c).maybe(:string)
            optional(:PhysicalAddressLine1__c).maybe(:string)
            optional(:PhysicalAddressLine2__c).maybe(:string)
            optional(:PhysicalAddrValidated__c).maybe(:string)
            optional(:PhysicalCertifiedNoStatIndicator__c).maybe(:string)
            optional(:PhysicalCity__c).maybe(:string)
            optional(:PhysicalCotVacancyIndicator__c).maybe(:string)
            optional(:PhysicalCountyCode__c).maybe(:string)
            optional(:PhysicalMailAddrDeliveryCode__c).maybe(:string)
            optional(:PhysicalResidentialDeliveryIndicator__c).maybe(:string)
            optional(:PhysicalStateCode__c).maybe(:string)
            optional(:PhysicalZipCode4__c).maybe(:string)
            optional(:PhysicalZipCode5__c).maybe(:string)
            optional(:PreferredIssuanceMethod__c).maybe(:string)
            optional(:PreferredSpokenLanguageCode__c).maybe(:string)
            optional(:PreferredWrittenLanguageCode__c).maybe(:string)
            optional(:PregnancyDueDate__c).maybe(:date)
            optional(:PregnancyExpectedDueDate__c).maybe(:date)
            optional(:PregnancyTerminationDate__c).maybe(:date)
            optional(:PrimaryPhoneExtension__c).maybe(:integer)
            optional(:PrimaryPhoneNumber__c).maybe(:string)
            optional(:PrimaryPhoneTypeCode__c).maybe(:string)
            optional(:PrisonerConfinementDate__c).maybe(:date)
            optional(:ProviderId__c).maybe(:integer)
            optional(:ProviderName__c).maybe(:string)
            optional(:PseudoSSN__c).maybe(:string)
            optional(:RaceCode__c).maybe(:string)
            optional(:ReceiptNumber__c).maybe(:string)
            optional(:ReceivesSSIBenefitsToggle__c).maybe(:string)
            optional(:RecordType).maybe(:hash)
            optional(:RecoveryDate__c).maybe(:date)
            optional(:ReturnToWorkDate__c).maybe(:date)
            optional(:RoutingNumber__c).maybe(:string)
            optional(:SecondaryPhoneExtension__c).maybe(:integer)
            optional(:SecondaryPhoneNumber__c).maybe(:string)
            optional(:SecondaryPhoneTypeCode__c).maybe(:string)
            optional(:SevisId__c).maybe(:string)
            optional(:SpecialNeedIndicatorToggle__c).maybe(:string)
            optional(:SponsoredByOrganization__c).maybe(:string)
            optional(:SSN__c).maybe(:string)
            optional(:SSNVerificationCode__c).maybe(:string)
            optional(:SSNVerificationDate__c).maybe(:date)
            optional(:SSNVerified__c).maybe(:bool)
            optional(:SuffixCode__c).maybe(:string)
            optional(:TaxFilerStatusNextYear__c).maybe(:string)
            optional(:TemporarilyLivesElsewhereToggle__c).maybe(:string)
            optional(:UnableToBuyCookForSelfToggle__c).maybe(:string)
            optional(:USCitizenCode__c).maybe(:string)
          end

          rule(:AlienNumber__c) do
            if key && value && value.match(/[^a-zA-Z\d-]/)
              key.failure(text: "invalid Alien Number - Special characters cannot be input into the field.",
                          error: result.errors.to_h)
            end
          end

          rule(:AlienNumber__c) do
            if key && value && value.length > 9
              key.failure(text: "invalid Alien Number - Needs to be less than 9 digits",
                          error: result.errors.to_h)
            end
          end

          rule(:AlienNumber__c) do
            if key && value && value.chars.to_a.uniq == ["0"]
              key.failure(text: "invalid Alien Number - Cannot be all 0s",
                          error: result.errors.to_h)
            end
          end

          rule(:SevisId__c) do
            if key && value && value.match(/[^a-zA-Z\d-]/)
              key.failure(text: "invalid Sevis ID - Special characters cannot be input into the field.",
                          error: result.errors.to_h)
            end
          end

          rule(:SevisId__c) do
            if key && value && value.length > 10
              key.failure(text: "invalid Sevis ID - Needs to be less than 10 digits",
                          error: result.errors.to_h)
            end
          end

          rule(:SevisId__c) do
            if key && value && value.chars.to_a.uniq == ["0"]
              key.failure(text: "invalid Sevis ID - Cannot be all 0s",
                          error: result.errors.to_h)
            end
          end

          rule(:I94Number__c) do
            re = Regexp.new('^\d{9}[a-zA-Z0-9]\d$').freeze
            if key && value && !value.match(re)
              key.failure(text: "invalid I94 Number - I-94 numbers should be 11 digits long with the format of 9 digits,
                                 followed by a letter or digit in the 10th position, and a digit in the 11th position",
                          error: result.errors.to_h)
            end
          end

          rule(:I94Number__c) do
            if key && value && value.delete("^0-9").chars.to_a.uniq == ["0"]
              key.failure(text: "invalid I94 Number - Cannot be all 0s",
                          error: result.errors.to_h)
            end
          end

          rule(:CitizenshipNumber__c) do
            if key && value && value.match(/[^\d-]/)
              key.failure(text: "invalid #{key} - Special characters cannot be input into the field.",
                          error: result.errors.to_h)
            end
          end

          rule(:CitizenshipNumber__c) do
            if key && value && !value.length.between?(6, 12)
              key.failure(text: "invalid citizenship Number - Needs to be between 6 to 12 digits",
                          error: result.errors.to_h)
            end
          end

          rule(:CitizenshipNumber__c) do
            if key && value && value.chars.to_a.uniq == ["0"]
              key.failure(text: "invalid citizenship Number - Cannot be all 0s",
                          error: result.errors.to_h)
            end
          end

          rule(:NaturalizationNumber__c) do
            if key && value && value.match(/[^\d-]/)
              key.failure(text: "invalid #{key} - Special characters cannot be input into the field.",
                          error: result.errors.to_h)
            end
          end

          rule(:NaturalizationNumber__c) do
            if key && value && !value.length.between?(6, 12)
              key.failure(text: "invalid citizenship Number - Needs to be between 6 to 12 digits",
                          error: result.errors.to_h)
            end
          end

          rule(:NaturalizationNumber__c) do
            if key && value && value.chars.to_a.uniq == ["0"]
              key.failure(text: "invalid citizenship Number - Cannot be all 0s",
                          error: result.errors.to_h)
            end
          end

          rule(:PassportNumber__c) do
            if key && value && value.match(/[^\d-]/)
              key.failure(text: "invalid #{key} - Special characters cannot be input into the field.",
                          error: result.errors.to_h)
            end
          end

          rule(:PassportNumber__c) do
            if key && value && !value.length.between?(6, 12)
              key.failure(text: "invalid citizenship Number - Needs to be between 6 to 12 digits",
                          error: result.errors.to_h)
            end
          end

          rule(:PassportNumber__c) do
            if key && value && value.chars.to_a.uniq == ["0"]
              key.failure(text: "invalid citizenship Number - Cannot be all 0s",
                          error: result.errors.to_h)
            end
          end

          rule(:ExpectedReturnDate__c) do
            if key && value && value < Date.today
              key.failure(text: "invalid ExpectedReturnDate__c - Date should be today or in the past.",
                          error: result.errors.to_h)
            end
          end

          rule(:PhysicalAddressLine2__c) do
            if key && value && value.match(%r{[^a-zA-Z\d\s.,#-‘&/]})
              key.failure(text: "invalid address line 2 - Only letters, numbers and the following special characters are allowed: (. , # - ‘ & /)",
                          error: result.errors.to_h)
            end
          end

          rule(:MailingAddressLine2__c) do
            if key && value && value.match(%r{[^a-zA-Z\d\s.,#-‘&/]})
              key.failure(text: "invalid address line 2 - Only letters, numbers and the following special characters are allowed: (. , # - ‘ & /)",
                          error: result.errors.to_h)
            end
          end

          rule(:PhysicalZipCode5__c) do
            if key && value && value.length != 5
              key.failure(text: "invalid #{key} - Only 5 characters allowed",
                          error: result.errors.to_h)
            end
          end

          rule(:MailingZipCode5__c) do
            if key && value && value.length != 5
              key.failure(text: "invalid #{key} - Only 5 characters allowed",
                          error: result.errors.to_h)
            end
          end

          rule(:PreferredNotificationMethodCode__c, :Email__c) do
            if key && value && values[:PreferredNotificationMethodCode__c] == "Electronic - Email" && values[:Email__c].nil?
              key.failure(text: "invalid contact method - You selected Email as your preferred method of contact but did not enter an email address.
                                 Please update your preferred method of contact or enter an email address.",
                          error: result.errors.to_h)
            end
          end

          rule(:PreferredNotificationMethodCode__c, :PrimaryPhoneTypeCode__c, :SecondaryPhoneTypeCode__c) do
            if key && value && (values[:PreferredNotificationMethodCode__c] == "Electronic - Text Message") &&
               (values[:PrimaryPhoneTypeCode__c] != "M" || value[:SecondaryPhoneTypeCode__c] != "M")
              key.failure(text: "invalid contact method - You selected Text Message but did not enter a mobile phone number.",
                          error: result.errors.to_h)
            end
          end

          rule(:PreferredNotificationMethodCode__c, :IsPrimaryTextPreferred__c) do
            if key && value && (values[:PreferredNotificationMethodCode__c] == "Electronic - Text Message") &&
               (values[:IsPrimaryTextPreferred__c] != "Y")
              key.failure(text: "invalid contact method - You did not allow us to send you text messages",
                          error: result.errors.to_h)
            end
          end

          rule(:PreferredNotificationMethodCode__c, :IsPrimaryTextPreferred__c) do
            if key && value && (values[:PreferredNotificationMethodCode__c] == "Electronic - Text Message") && values[:IsPrimaryTextPreferred__c].nil?
              key.failure(text: "missing if allow us to send you text messages",
                          error: result.errors.to_h)
            end
          end

          rule(:PregnancyDueDate__c) do
            if key && value && value > Date.today + 279
              key.failure(text: "invalid PregnancyDueDate__c - Date should no more than 9 months in the future.",
                          error: result.errors.to_h)
            end
          end

          rule(:PrimaryPhoneExtension__c) do
            if key && value && value.to_s.length > 10
              key.failure(text: "invalid PrimaryPhoneExtension__c - Phone extensions should not be more than 10 digits.",
                          error: result.errors.to_h)
            end
          end

          rule(:PrimaryPhoneNumber__c) do
            re = Regexp.new('^\d{3}-\d{3}-\d{4}$').freeze
            if key && value && !value.match(re)
              key.failure(text: "invalid Primary Phone Number - must be a valid 10-digit number in the following format: “123-456-7890”.",
                          error: result.errors.to_h)
            end
          end

          rule(:SecondaryPhoneNumber__c) do
            re = Regexp.new('^\d{3}-\d{3}-\d{4}$').freeze
            if key && value && !value.match(re)
              key.failure(text: "invalid Primary Phone Number - must be a valid 10-digit number in the following format: “123-456-7890”.",
                          error: result.errors.to_h)
            end
          end

          rule(:SecondaryPhoneTypeCode__c, :PrimaryPhoneTypeCode__c) do
            if key && value && (values[:SecondaryPhoneTypeCode__c] == values[:PrimaryPhoneTypeCode__c])
              key.failure(text: "invalid phone type - The phone type for the primary and secondary phone number cannot be the same.",
                          error: result.errors.to_h)
            end
          end

          rule(:PrisonerConfinementDate__c) do
            if key && value && value > Date.today
              key.failure(text: "invalid PrisonerConfinementDate__c - Date should be today or in the past.",
                          error: result.errors.to_h)
            end
          end

          rule(:ReceiptNumber__c) do
            re = Regexp.new('^[a-zA-Z]{3}\d{10}$').freeze
            if key && value && !value.match(re)
              key.failure(text: "invalid Receipt Number - Please enter a valid Card Number with 13 characters, the first three of which are letters.",
                          error: result.errors.to_h)
            end
          end

          rule(:IsUSCitizenToggle__c, :ImmigrationDocumentTypeCode__c) do
            if key && value && (values[:IsUSCitizenToggle__c] == "N" && values[:ImmigrationDocumentTypeCode__c].nil?)
              key.failure(text: "missing Immigration Document Type - Immigration document type is required if not US citizen",
                          error: result.errors.to_h)
            end
          end

          rule(:ImmigrationDocumentTypeCode__c, :AlienNumber__c) do
            doc_types =
              ["Member of a federally recognized Indian tribe or American Indian born in Canada",
               "I-551 (Permanent Resident Card)",
               "Cuban/Haitian entrant",
               "Certificate of Citizenship in non-US country",
               "Administrative order staying removal issued by DHS",
               "Certification from HHS", "I-327 (Reentry Permit)",
               "Temporary I-551 Stamp (on passport or I-94)",
               "I-571 (Refugee Travel Document)",
               "I-766 (Employment Authorization Card)",
               "Notice of Action (I-797)",
               "Machine Readable Immigrant Visa (with Temporary I-551 Language)",
               "Naturalization Certificate",
               "Office of Refugee Resettlement eligibility letter (if under 18)",
               "Office of Refugee Resettlement",
               "Other Immigration Document",
               "Resident of American Samoa",
               "Document indicating withholding of removal",
               "Petition under section 204(a)(1)(A) or (B) of INA",
               "Petition under section 244(a)(3) of INA",
               "Conversion",
               "Not Available"]
            if key && value && (doc_types.include?(values[:ImmigrationDocumentTypeCode__c]) && values[:AlienNumber__c].nil?)
              key.failure(text: "missing alien number",
                          error: result.errors.to_h)
            end
          end

          rule(:ImmigrationDocumentTypeCode__c, :CitizenshipNumber__c) do
            doc_types = ["Certificate of Citizenship in non-US country"]
            if key && value && (doc_types.include?(values[:ImmigrationDocumentTypeCode__c]) && values[:CitizenshipNumber__c].nil?)
              key.failure(text: "missing citizenship number",
                          error: result.errors.to_h)
            end
          end

          rule(:ImmigrationDocumentTypeCode__c, :NaturalizationNumber__c) do
            doc_types = ["Naturalization Certificate"]
            if key && value && (doc_types.include?(values[:ImmigrationDocumentTypeCode__c]) && values[:NaturalizationNumber__c].nil?)
              key.failure(text: "missing Naturalization number",
                          error: result.errors.to_h)
            end
          end

          rule(:ImmigrationDocumentTypeCode__c, :CountryOfIssuanceCode__c) do
            doc_types = ["I-94 (Arrival/Departure Record) in Unexpired Foreign Passport",
                         "Unexpired Foreign Passport or Machine Readable Immigrant Visa (with Temporary I-551 Language)"]
            if key && value && (doc_types.include?(values[:ImmigrationDocumentTypeCode__c]) && values[:CountryOfIssuanceCode__c].nil?)
              key.failure(text: "missing country code",
                          error: result.errors.to_h)
            end
          end

          rule(:ImmigrationDocumentTypeCode__c, :I94Number__c) do
            doc_types = ["I-94 (Arrival/Departure Record) in Unexpired Foreign Passport",
                         "Unexpired Foreign Passport or Machine Readable Immigrant Visa (with Temporary I-551 Language)"]
            if key && value && (doc_types.include?(values[:ImmigrationDocumentTypeCode__c]) && values[:I94Number__c].nil?)
              key.failure(text: "missing I-94 number",
                          error: result.errors.to_h)
            end
          end

          rule(:ImmigrationDocumentTypeCode__c, :DocumentExpiryDate__c) do
            doc_types = ["I-94 (Arrival/Departure Record) in Unexpired Foreign Passport",
                         "Unexpired Foreign Passport or Machine Readable Immigrant Visa (with Temporary I-551 Language)"]
            if key && value && (doc_types.include?(values[:ImmigrationDocumentTypeCode__c]) && values[:DocumentExpiryDate__c].nil?)
              key.failure(text: "missing document expiry date",
                          error: result.errors.to_h)
            end
          end

          rule(:ImmigrationDocumentTypeCode__c, :DocumentOtherDescription__c) do
            doc_types =
              ["Cuban/Haitian entrant",
               "Administrative order staying removal issued by DHS",
               "Certification from HHS",
               "Notice of Action (I-797)", "Office of Refugee Resettlement eligibility letter (if under 18)",
               "Office of Refugee Resettlement",
               "Other Immigration Document",
               "Resident of American Samoa",
               "Document indicating withholding of removal",
               "Petition under section 204(a)(1)(A) or (B) of INA p",
               "Petition under section 244(a)(3) of INA",
               "Conversion",
               "Not Available",
               "Member of a federally recognized Indian tribe or American Indian born in Canada"]
            if key && value && (doc_types.include?(values[:ImmigrationDocumentTypeCode__c]) && values[:DocumentOtherDescription__c].nil?)
              key.failure(text: "missing other document description",
                          error: result.errors.to_h)
            end
          end

          rule(:ImmigrationDocumentTypeCode__c, :SevisId__c) do
            doc_types = ["DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)",
                         "I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)"]
            if key && value && (doc_types.include?(values[:ImmigrationDocumentTypeCode__c]) && values[:SevisId__c].nil?)
              key.failure(text: "missing Sevis id",
                          error: result.errors.to_h)
            end
          end

          rule(:ImmigrationDocumentTypeCode__c, :ReceiptNumber__c) do
            doc_types = ["I-551 (Permanent Resident Card)", "I-766 (Employment Authorization Card)"]
            if key && value && (doc_types.include?(values[:ImmigrationDocumentTypeCode__c]) && values[:ReceiptNumber__c].nil?)
              key.failure(text: "missing Receipt ",
                          error: result.errors.to_h)
            end
          end

          rule(:ImmigrationDocumentTypeCode__c, :PassportNumber__c) do
            doc_types = ["I-94 (Arrival/Departure Record) in Unexpired Foreign Passport",
                         "Unexpired Foreign Passport or Machine Readable Immigrant Visa (with Temporary I-551 Language)"]
            if key && value && (doc_types.include?(values[:ImmigrationDocumentTypeCode__c]) && values[:PassportNumber__c].nil?)
              key.failure(text: "missing Receipt ",
                          error: result.errors.to_h)
            end
          end

          rule(:IsFosterCareToggle__c, :FosterStateCode__c) do
            if key && value && (values[:IsFosterCareToggle__c] == "Y" && values[:FosterStateCode__c].nil?)
              key.failure(text: "missing foster state code",
                          error: result.errors.to_h)
            end
          end

          rule(:IsFosterCareToggle__c, :IsStateMedicaidprogramCode__c) do
            if key && value && (values[:IsFosterCareToggle__c] == "Y" && values[:IsStateMedicaidprogramCode__c].nil?)
              key.failure(text: "missing former foster care medicaid",
                          error: result.errors.to_h)
            end
          end

          rule(:IsFederalRecognizedIndianTribeToggle__c, :IndianTribeCode__c) do
            if key && value && (values[:IsFederalRecognizedIndianTribeToggle__c] == "Y" && values[:IndianTribeCode__c].nil?)
              key.failure(text: "missing tribe code(s) for " + values[:FirstName__c],
                          error: result.errors.to_h)
            end
          end

          rule(:IsPregnant__c, :NumberOfBirthsExpected__c) do
            if key && value && (values[:IsPregnant__c] == "Y" && values[:NumberOfBirthsExpected__c].nil?)
              key.failure(text: "missing number of births expected",
                          error: result.errors.to_h)
            end
          end

          rule(:IsPregnant__c, :PregnancyDueDate__c) do
            if key && value && (values[:IsPregnant__c] == "Y" && values[:PregnancyDueDate__c].nil?)
              key.failure(text: "missing due date",
                          error: result.errors.to_h)
            end
          end

          rule(:IsFixedAddressToggle__c, :PhysicalAddressLine1__c) do
            if key && value && (values[:IsFixedAddressToggle__c] == "Y" && values[:PhysicalAddressLine1__c].nil?)
              key.failure(text: "missing address line 1",
                          error: result.errors.to_h)
            end
          end

          rule(:IsFixedAddressToggle__c, :PhysicalCity__c) do
            if key && value && (values[:IsFixedAddressToggle__c] == "Y" && values[:PhysicalCity__c].nil?)
              key.failure(text: "missing city",
                          error: result.errors.to_h)
            end
          end

          rule(:IsFixedAddressToggle__c, :PhysicalStateCode__c) do
            if key && value && (values[:IsFixedAddressToggle__c] == "Y" && values[:PhysicalStateCode__c].nil?)
              key.failure(text: "missing state",
                          error: result.errors.to_h)
            end
          end

          rule(:IsFixedAddressToggle__c, :PhysicalCity__c) do
            if key && value && (values[:IsFixedAddressToggle__c] == "Y" && values[:PhysicalZipCode5__c].nil?)
              key.failure(text: "missing zip",
                          error: result.errors.to_h)
            end
          end

          rule(:IsFixedAddressToggle__c, :PhysicalZipCode5__c) do
            if key && value && (values[:IsFixedAddressToggle__c] == "Y" && values[:PhysicalZipCode5__c].nil?)
              key.failure(text: "missing zip",
                          error: result.errors.to_h)
            end
          end

          rule(:HasDifferentMailingAddress__c, :MailingAddressLine1__c) do
            if key && value && (values[:HasDifferentMailingAddress__c] == "Y" && values[:MailingAddressLine1__c].nil?)
              key.failure(text: "missing address line 1",
                          error: result.errors.to_h)
            end
          end

          rule(:HasDifferentMailingAddress__c, :MailingCity__c) do
            if key && value && (values[:HasDifferentMailingAddress__c] == "Y" && values[:MailingCity__c].nil?)
              key.failure(text: "missing city",
                          error: result.errors.to_h)
            end
          end

          rule(:HasDifferentMailingAddress__c, :MailingStateCode__c) do
            if key && value && (values[:HasDifferentMailingAddress__c] == "Y" && values[:MailingStateCode__c].nil?)
              key.failure(text: "missing state",
                          error: result.errors.to_h)
            end
          end

          rule(:HasDifferentMailingAddress__c, :MailingCity__c) do
            if key && value && (values[:HasDifferentMailingAddress__c] == "Y" && values[:MailingCity__c].nil?)
              key.failure(text: "missing zip",
                          error: result.errors.to_h)
            end
          end

          rule(:HasDifferentMailingAddress__c, :MailingZipCode5__c) do
            if key && value && (values[:HasDifferentMailingAddress__c] == "Y" && values[:MailingZipCode5__c].nil?)
              key.failure(text: "missing zip",
                          error: result.errors.to_h)
            end
          end

        end
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength