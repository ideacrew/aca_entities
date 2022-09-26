# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_Application__c
        class SspApplicationCContract < Dry::Validation::Contract
          params do
            optional(:ApplicationReceivedDateTime__c).maybe(:date_time)
            optional(:DCsnapHouseholdExpeditedScreeningId__c).maybe(:integer)
            optional(:DeclrtnfAnnuitiesAcceptanceCode__c).maybe(:string)
            optional(:HasShelterExpExceedIncomeResourcesToggle__c).maybe(:string)
            optional(:HouseholdTotalMonthlyCashSavingAmount__c).maybe(:float)
            optional(:HouseholdTotalMonthlyGrossIncAmount__c).maybe(:float)
            optional(:IsApplicantAgreeToWorkRegister__c).maybe(:string)
            optional(:IsAssetsInExcess1M__c).maybe(:bool)
            optional(:IsDestituteFarmOrMigrantHouseholdToggle__c).maybe(:string)
            optional(:IsReceivingHousingAssistanceToggle__c).maybe(:string)
            optional(:IsRenewalConsent__c).maybe(:string)
            optional(:Name).maybe(:string)
            optional(:ProgramsApplied__c).maybe(:string)
            optional(:Status__c).maybe(:string)
            optional(:DcCaseNumber__c).maybe(:string)
            optional(:Id).maybe(:string)
            optional(:Account__c).maybe(:string)
            optional(:IsRegisteredToVote__c).maybe(:string)
            optional(:Contact__c).maybe(:string)
            optional(:ApplicationId__c).maybe(:string)
            optional(:IsApplicantAuthorizedRepresentative__c).maybe(:string)
            optional(:IsApplicationSubmittedEarly__c).maybe(:string)
            optional(:IsRACAddIndividuals__c).maybe(:string)
            optional(:IsDMSAnnuitiesBeneficiary__c).maybe(:string)
            optional(:IsFleeingFelonToggle__c).maybe(:string)
            optional(:IsParticipatingCompltdTreatmentToggle__c).maybe(:string)
            optional(:IsConvictedChemicallyDependentToggle__c).maybe(:string)
            optional(:IsConvictedOfDrugFelonyToggle__c).maybe(:string)
            optional(:HasGivenWrongInformationToggle__c).maybe(:string)
            optional(:HasConvictedOfBuyingSellingToggle__c).maybe(:string)
            optional(:HasConvictedOfTradingFirearm__c).maybe(:string)
            optional(:HasConvictedOfTradingDrugsToggle__c).maybe(:string)
            optional(:HasAnnuityToggle__c).maybe(:string)
            optional(:HasSpecialNeedTrustToggle__c).maybe(:string)
            optional(:HasBurialFundToggle__c).maybe(:string)
            optional(:HasBurialPlotsToggle__c).maybe(:string)
            optional(:HasPromissoryNoteOrLandContractToggle__c).maybe(:string)
            optional(:HasOtherResourceToggle__c).maybe(:string)
            optional(:HasLifeEstateToggle__c).maybe(:string)
            optional(:HasLTCAgreementToggle__c).maybe(:string)
            optional(:HasPartnershipQualifiedLTCPolicyToggle__c).maybe(:string)
            optional(:HasLifeSettlementContractToggle__c).maybe(:string)
            optional(:IsAssetsInExcess1MToggle__c).maybe(:string)
            optional(:IsSignedbyAuthorizedRepresentative__c).maybe(:string)
            optional(:IsAgreeingToMedicaidPenalty__c).maybe(:string)
            optional(:HasPendingAccidentSettlementToggle__c).maybe(:string)
            optional(:IsPrimaryApplicantAddressModified__c).maybe(:bool)
            required(:NotEnrolledInHealthCareCoverageToggle__c).filled(:string)
            required(:ApplicationEsignFirstName__c).filled(:string)
            required(:ApplicationEsignLastName__c).filled(:string)
            optional(:ApplicationEsignMiddleName__c).maybe(:string)
            optional(:ApplicationEsignSuffixCode__c).maybe(:string)
          end
        end
      end
    end
  end
end