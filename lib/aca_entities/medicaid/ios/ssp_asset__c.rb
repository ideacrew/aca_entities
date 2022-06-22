# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for SSP_Asset__c
      class SSPAssetC < Dry::Struct
        attribute :SSP_Member__c, Types::String.optional.meta(omittable: true)
        attribute :ProviderName__C, Types::String.optional.meta(omittable: true)
        attribute :IsExistingData__c, Types::Boolean.optional.meta(omittable: true)
        attribute :IsDeleted__c, Types::Boolean.optional.meta(omittable: true)
        attribute :RecordTypeId, Types::String.optional.meta(omittable: true)
        attribute :Id, Types::String.optional.meta(omittable: true)
        attribute :AccountBalance__c, Types::Float.optional.meta(omittable: true)
        attribute :ActivityStartDate__c, Types::Date.optional.meta(omittable: true)
        attribute :ActivityType__c, Types::String.optional.meta(omittable: true)
        attribute :ReceiveInHouseAssistance__c, Types::String.optional.meta(omittable: true)
        attribute :RecordType, RecordType.optional.meta(omittable: true)
        attribute :AddressLine1__c, Types::String.optional.meta(omittable: true)
        attribute :AddressLine2__c, Types::String.optional.meta(omittable: true)
        attribute :BooksAmount__c, Types::Float.optional.meta(omittable: true)
        attribute :BusinessTitle__c, Types::String.optional.meta(omittable: true)
        attribute :BusinessTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :CashSurrenderValue__c, Types::Float.optional.meta(omittable: true)
        # ChildName__c "RequiredValidator; MaxStringLengthValidator(25); NameIllegalCharactersValidator"
        attribute :ChildName__c, Types::String.optional.meta(omittable: true)
        attribute :City__c, Types::String.optional.meta(omittable: true)
        attribute :CountyCode__c, Types::String.optional.meta(omittable: true)
        attribute :DateOfissuance__c, Types::Date.optional.meta(omittable: true)
        attribute :DateOwned__c, Types::Date.optional.meta(omittable: true)
        attribute :DCAddressId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCEmploymentDetailId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCExpenseDetailId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCResourceValueDetailId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCResourceMiscellaneousDetailId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCResourceOwnershipDetailId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCSelfEmploymentIncomeDetailId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DCUnearnedIncomeDetailId__c, Types::Integer.optional.meta(omittable: true)
        attribute :DependentCareProvider__c, Types::String.optional.meta(omittable: true)
        attribute :DependentCareProviderId, Types::Integer.optional.meta(omittable: true)
        attribute :DependentIndividual__c, Types::String.optional.meta(omittable: true)
        attribute :EIN__c, Types::Integer.optional.meta(omittable: true)
        attribute :EmployerName__c, Types::String.optional.meta(omittable: true)
        attribute :EmploymentEndReason__c, Types::String.optional.meta(omittable: true)
        attribute :EndDate__c, Types::Date.optional.meta(omittable: true) # RequiredValidator, FutureDateValidator, EndDateStartDateValidator
        attribute :ExpenseAmount__c, Types::Float.optional.meta(omittable: true) # CurrencyValidator, RequiredValidator
        attribute :ExpenseFrequencyCode__c, Types::String.optional.meta(omittable: true)
        attribute :ExpenseSubType__c, Types::String.optional.meta(omittable: true)
        attribute :ExpenseTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :FaceValueAmount__c, Types::Integer.optional.meta(omittable: true)
        attribute :FeesAmount__c, Types::Integer.optional.meta(omittable: true)
        attribute :FuneralFundCode__c, Types::String.optional.meta(omittable: true)
        attribute :FuneralLocation__c, Types::String.optional.meta(omittable: true)
        attribute :HasItemizedStmtOfGoodsSignByClientToggle__c, Types::String.optional.meta(omittable: true)
        attribute :HasPolicyAssignedToFuneralHomeToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IncomePayDetailHoursPerWeek__c, Types::Integer.optional.meta(omittable: true)
        attribute :IncomePayFrequency__c, Types::String.optional.meta(omittable: true)
        attribute :IncomeTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :IncomeSubtypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :InsuranceCompanyAddress__c, Types::String.optional.meta(omittable: true)
        attribute :InsuranceCompanyName__c, Types::String.optional.meta(omittable: true)
        attribute :InsuranceCompanyPhoneNumber__c, Types::String.optional.meta(omittable: true)
        attribute :InsurancePolicyAsset__c, Types::String.optional.meta(omittable: true)
        attribute :IsHomeHomesteadPropertyToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsIncomeEssentialToSelfSupportToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsMoneyPaidToOutsideToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsNonHouseHoldMemberPayingExpenseToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsPolicyDesignatedToPayBurialToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsPolicyUsedForPrearrangedFuneralToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsSchoolDegreeRequiredToggle__c, Types::String.optional.meta(omittable: true)
        attribute :IsUnempBenefitsRequiredToggle__c, Types::String.optional.meta(omittable: true)
        attribute :LoanBalance__c, Types::Float.optional.meta(omittable: true)
        attribute :Location__c, Types::String.optional.meta(omittable: true)
        attribute :Make__c, Types::String.optional.meta(omittable: true)
        attribute :MiscellaneousAmount__c, Types::Float.optional.meta(omittable: true)
        attribute :Model__c, Types::Integer.optional.meta(omittable: true)
        attribute :ModelYear__c, Types::String.optional.meta(omittable: true)
        attribute :NoAccessReason__c, Types::String.optional.meta(omittable: true)
        attribute :NotEnoughInformation__c, Types::Boolean.optional.meta(omittable: true)
        attribute :PolicyNumber__c, Types::String.optional.meta(omittable: true)
        attribute :PreFuneralAgmtGoodsAndServicesCost__c, Types::Float.optional.meta(omittable: true)
        attribute :PrimaryPhoneExtension__c, Types::String.optional.meta(omittable: true)
        attribute :PrimaryPhoneNumber__c, Types::String.optional.meta(omittable: true) # PhoneNumberValidator
        attribute :PrimaryUserIndividual__c, Types::String.optional.meta(omittable: true)
        attribute :PrimaryUserIfOther__c, Types::String.optional.meta(omittable: true)
        attribute :RealEstateFairMarketValue__c, Types::Float.optional.meta(omittable: true)
        attribute :ResourceEndDate__c, Types::Date.optional.meta(omittable: true)
        attribute :ResourceEndReason__c, Types::String.optional.meta(omittable: true)
        attribute :ResourceSubTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :ResourceTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :StartDate__c, Types::Date.optional.meta(omittable: true) # FutureDateValidator, RequiredValidator
        attribute :StateCode__c, Types::String.optional.meta(omittable: true)
        attribute :Tips__c, Types::Float.optional.meta(omittable: true)
        attribute :TotalGrossAmount__c, Types::Float.optional.meta(omittable: true) # RequiredValidator, NotZeroValidator, CurrencyValidator
        attribute :TuitionAmount__c, Types::Float.optional.meta(omittable: true)
        attribute :VehicleCategoryCode__c, Types::String.optional.meta(omittable: true)
        attribute :VehicleDebt__c, Types::Float.optional.meta(omittable: true)
        attribute :VehicleFairMarketValue__c, Types::Float.optional.meta(omittable: true)
        attribute :VehicleTypeCode__c, Types::String.optional.meta(omittable: true)
        attribute :VehicleUseReason__c, Types::String.optional.meta(omittable: true)
        attribute :ZipCode4__c, Types::String.optional.meta(omittable: true)
        attribute :ZipCode5__c, Types::String.optional.meta(omittable: true)
        attribute :IndividualId__c, Types::Integer.optional.meta(omittable: true)
        attribute :IsThereAnotherOwnerToggle__c, Types::String.optional.meta(omittable: true)
        # attribute :DependentCareProvider__r, DependentCareProvider__r.optional.meta(omittable: true)
        # attribute :DependentIndividual__r, DependentIndividual__r.optional.meta(omittable: true)
        attribute :DCResourceDetailId__c, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end

# WhoIsThisMedicalExpensePaidTo__c, End_Date_Of_Employment__c, WasDivorceAgreementDateBefore2019__c