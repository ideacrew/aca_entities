# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Medicaid
    module Ios
      module Transformers
        # CV3 Application transform to IOS payload format
        class Application < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'primary_applicant.name.first_name', 'ApplicationEsignFirstName__c'
          map 'primary_applicant.name.middle_name', 'ApplicationEsignMiddleInitial__c'
          map 'primary_applicant.name.last_name', 'ApplicationEsignLastName__c'
          #   map '???', 'ApplicationReceivedDateTime__c'
          #   map '???', 'DCsnapHouseholdExpeditedScreeningId__c'
          #   map '???', 'DeclrtnfAnnuitiesAcceptanceCode__c'
          #   map '???', 'HasShelterExpExceedIncomeResourcesToggle__c'
          #   map '???', 'HouseholdTotalMonthlyCashSavingAmount__c'
          #   map '???', 'HouseholdTotalMonthlyGrossIncAmount__c'
          #   map '???', 'IsApplicantAgreeToWorkRegister__c'
          #   map '???', 'IsAssetsInExcess1M__c'
          #   map '???', 'IsDestituteFarmOrMigrantHouseholdToggle__c'
          #   map '???', 'IsReceivingHousingAssistanceToggle__c'
          #   map '???', 'IsRenewalConsent__c'
          #   map '???', 'Name'
          #   map '???', 'ProgramsApplied__c'
          #   map '???', 'Status__c'
          #   map '???', 'DcCaseNumber__c'
          #   map '???', 'Id'
          #   map '???', 'Account__c'
          #   map '???', 'IsRegisteredToVote__c'
          #   map '???', 'Contact__c'
          #   map '???', 'ApplicationId__c'
          #   map '???', 'IsApplicantAuthorizedRepresentative__c'
          #   map '???', 'IsApplicationSubmittedEarly__c'
          #   map '???', 'IsRACAddIndividuals__c'
          #   map '???', 'IsDMSAnnuitiesBeneficiary__c'
          #   map '???', 'IsFleeingFelonToggle__c'
          #   map '???', 'IsParticipatingCompltdTreatmentToggle__c'
          #   map '???', 'IsConvictedChemicallyDependentToggle__c'
          #   map '???', 'IsConvictedOfDrugFelonyToggle__c'
          #   map '???', 'HasGivenWrongInformationToggle__c'
          #   map '???', 'HasConvictedOfBuyingSellingToggle__c'
          #   map '???', 'HasConvictedOfTradingFirearm__c'
          #   map '???', 'HasConvictedOfTradingDrugsToggle__c'
          #   map '???', 'HasAnnuityToggle__c'
          #   map '???', 'HasSpecialNeedTrustToggle__c'
          #   map '???', 'HasBurialFundToggle__c'
          #   map '???', 'HasBurialPlotsToggle__c'
          #   map '???', 'HasPromissoryNoteOrLandContractToggle__c'
          #   map '???', 'HasOtherResourceToggle__c'
          #   map '???', 'HasLifeEstateToggle__c'
          #   map '???', 'HasLTCAgreementToggle__c'
          #   map '???', 'HasPartnershipQualifiedLTCPolicyToggle__c'
          #   map '???', 'HasLifeSettlementContractToggle__c'
          #   map '???', 'IsAssetsInExcess1MToggle__c'
          #   map '???', 'IsSignedbyAuthorizedRepresentative__c'
          #   map '???', 'IsAgreeingToMedicaidPenalty__c'
          #   map '???', 'HasPendingAccidentSettlementToggle__c'
          #   map '???', 'IsPrimaryApplicantAddressModified__c'
          #   map '???', 'NotEnrolledInHealthCareCoverageToggle__c'
        end
      end
    end
  end
end