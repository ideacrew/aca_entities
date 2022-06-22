# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for SSP_Application__c
      class SSPApplicationC < Dry::Struct
        attribute :ApplicationReceivedDateTime__c, Types::DateTime.optional.meta(omittable: true)
        attribute :DCsnapHouseholdExpeditedScreeningId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DeclrtnfAnnuitiesAcceptanceCode__c, Types::String.optional.meta(omittable: true)
        attribute :HasShelterExpExceedIncomeResourcesToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HouseholdTotalMonthlyCashSavingAmount__c, Types::Float.optional.meta(omittable: true)
        attribute :HouseholdTotalMonthlyGrossIncAmount__c, Types::Float.optional.meta(omittable: true)
        attribute :IsApplicantAgreeToWorkRegister__c, Types::String.optional.meta(omittable: true)
        attribute :IsAssetsInExcess1M__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsDestituteFarmOrMigrantHouseholdToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsReceivingHousingAssistanceToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsRenewalConsent__c, Types::String.optional.meta(omittable: true)
        attribute :Name, Types::String.optional.meta(omittable: true)
        attribute :ProgramsApplied__c, Types::String.optional.meta(omittable: true)
        attribute :Status__c, Types::String.optional.meta(omittable: true)
        attribute :DcCaseNumber__c, Types::Integer.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :Account__c, Types::String.optional.meta(omittable: true)
        attribute :IsRegisteredToVote__c, Types::String.optional.meta(omittable: true)
        attribute :Contact__c, Types::String.optional.meta(omittable: true)
        attribute :ApplicationId__c, Types::String.optional.meta(omittable: true)
        attribute :IsApplicantAuthorizedRepresentative__c, Types::String.optional.meta(omittable: true)
        attribute :IsApplicationSubmittedEarly__c, Types::String.optional.meta(omittable: true)
        attribute :IsRACAddIndividuals__c, Types::String.optional.meta(omittable: true)
        attribute :IsDMSAnnuitiesBeneficiary__c, Types::String.optional.meta(omittable: true)
        attribute :IsFleeingFelonToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsParticipatingCompltdTreatmentToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsConvictedChemicallyDependentToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsConvictedOfDrugFelonyToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasGivenWrongInformationToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasConvictedOfBuyingSellingToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasConvictedOfTradingFirearm__c, Types::String.optional.meta(omittable: true)
        attribute :HasConvictedOfTradingDrugsToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasAnnuityToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasSpecialNeedTrustToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasBurialFundToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasBurialPlotsToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasPromissoryNoteOrLandContractToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasOtherResourceToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasLifeEstateToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasLTCAgreementToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasPartnershipQualifiedLTCPolicyToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasLifeSettlementContractToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsAssetsInExcess1MToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsSignedbyAuthorizedRepresentative__c, Types::String.optional.meta(omittable: true)
        attribute :IsAgreeingToMedicaidPenalty__c, Types::String.optional.meta(omittable: true)
        attribute :HasPendingAccidentSettlementToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsPrimaryApplicantAddressModified__c, Types::Boolean.optional.meta(omittable: true)
        # NotEnrolledInHealthCareCoverageToggle__c: not in schema RequiredValidator
        attribute :NotEnrolledInHealthCareCoverageToggle__c, Types::String.optional.meta(omittable: true)
      end
    end
  end
end