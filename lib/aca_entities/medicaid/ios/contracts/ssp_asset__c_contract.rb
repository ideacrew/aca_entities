# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for SSP_Asset__c
        class SspAssetCContract < Dry::Validation::Contract
          params do
            optional(:SSP_Member__c).maybe(:string)
            optional(:ProviderName__C).maybe(:string)
            optional(:IsExistingData__c).maybe(:bool)
            optional(:IsDeleted__c).maybe(:bool)
            optional(:RecordTypeId).maybe(:string)
            optional(:Id).maybe(:string)
            optional(:AccountBalance__c).maybe(:float)
            optional(:ActivityStartDate__c).maybe(:date)
            optional(:ActivityType__c).maybe(:string)
            optional(:ReceiveInHouseAssistance__c).maybe(:string)
            optional(:RecordType).maybe(:hash)
            optional(:AddressLine1__c).maybe(:string)
            optional(:AddressLine2__c).maybe(:string)
            optional(:BooksAmount__c).maybe(:float)
            optional(:BusinessTitle__c).maybe(:string)
            optional(:BusinessTypeCode__c).maybe(:string)
            optional(:CashSurrenderValue__c).maybe(:float)
            optional(:ChildName__c).maybe(:string)
            optional(:City__c).maybe(:string)
            optional(:CountyCode__c).maybe(:string)
            optional(:DateOfissuance__c).maybe(:date)
            optional(:DateOwned__c).maybe(:date)
            optional(:DCAddressId__c).maybe(:integer)
            optional(:DCEmploymentDetailId__c).maybe(:integer)
            optional(:DCExpenseDetailId__c).maybe(:integer)
            optional(:DCId__c).maybe(:integer)
            optional(:DCResourceValueDetailId__c).maybe(:integer)
            optional(:DCResourceMiscellaneousDetailId__c).maybe(:integer)
            optional(:DCResourceOwnershipDetailId__c).maybe(:integer)
            optional(:DCSelfEmploymentIncomeDetailId__c).maybe(:integer)
            optional(:DCUnearnedIncomeDetailId__c).maybe(:integer)
            optional(:DependentCareProvider__c).maybe(:string)
            optional(:DependentCareProviderId).maybe(:integer)
            optional(:DependentIndividual__c).maybe(:string)
            optional(:EIN__c).maybe(:integer)
            optional(:EmployerName__c).maybe(:string)
            optional(:EmploymentEndReason__c).maybe(:string)
            optional(:EndDate__c).maybe(:date)
            optional(:ExpenseAmount__c).maybe(:float)
            optional(:ExpenseFrequencyCode__c).maybe(:string)
            optional(:ExpenseSubType__c).maybe(:string)
            optional(:ExpenseTypeCode__c).maybe(:string)
            optional(:FaceValueAmount__c).maybe(:integer)
            optional(:FeesAmount__c).maybe(:integer)
            optional(:FuneralFundCode__c).maybe(:string)
            optional(:FuneralLocation__c).maybe(:string)
            optional(:HasItemizedStmtOfGoodsSignByClientToggle__c).maybe(:string)
            optional(:HasPolicyAssignedToFuneralHomeToggle__c).maybe(:string)
            optional(:IncomePayDetailHoursPerWeek__c).maybe(:integer)
            optional(:IncomePayFrequency__c).maybe(:string)
            optional(:IncomeTypeCode__c).maybe(:string)
            optional(:IncomeSubtypeCode__c).maybe(:string)
            optional(:InsuranceCompanyAddress__c).maybe(:string)
            optional(:InsuranceCompanyName__c).maybe(:string)
            optional(:InsuranceCompanyPhoneNumber__c).maybe(:string)
            optional(:InsurancePolicyAsset__c).maybe(:string)
            optional(:IsHomeHomesteadPropertyToggle__c).maybe(:string)
            optional(:IsIncomeEssentialToSelfSupportToggle__c).maybe(:string)
            optional(:IsMoneyPaidToOutsideToggle__c).maybe(:string)
            optional(:IsNonHouseHoldMemberPayingExpenseToggle__c).maybe(:string)
            optional(:IsPolicyDesignatedToPayBurialToggle__c).maybe(:string)
            optional(:IsPolicyUsedForPrearrangedFuneralToggle__c).maybe(:string)
            optional(:IsSchoolDegreeRequiredToggle__c).maybe(:string)
            optional(:IsUnempBenefitsRequiredToggle__c).maybe(:string)
            optional(:LoanBalance__c).maybe(:float)
            optional(:Location__c).maybe(:string)
            optional(:Make__c).maybe(:string)
            optional(:MiscellaneousAmount__c).maybe(:float)
            optional(:Model__c).maybe(:integer)
            optional(:ModelYear__c).maybe(:string)
            optional(:NoAccessReason__c).maybe(:string)
            optional(:NotEnoughInformation__c).maybe(:bool)
            optional(:PolicyNumber__c).maybe(:string)
            optional(:PreFuneralAgmtGoodsAndServicesCost__c).maybe(:float)
            optional(:PrimaryPhoneExtension__c).maybe(:string)
            optional(:PrimaryPhoneNumber__c).maybe(:string)
            optional(:PrimaryUserIndividual__c).maybe(:string)
            optional(:PrimaryUserIfOther__c).maybe(:string)
            optional(:RealEstateFairMarketValue__c).maybe(:float)
            optional(:ResourceEndDate__c).maybe(:date)
            optional(:ResourceEndReason__c).maybe(:string)
            optional(:ResourceSubTypeCode__c).maybe(:string)
            optional(:ResourceTypeCode__c).maybe(:string)
            optional(:StartDate__c).maybe(:date)
            optional(:StateCode__c).maybe(:string)
            optional(:Tips__c).maybe(:float)
            optional(:TotalGrossAmount__c).maybe(:float)
            optional(:TuitionAmount__c).maybe(:float)
            optional(:VehicleCategoryCode__c).maybe(:string)
            optional(:VehicleDebt__c).maybe(:float)
            optional(:VehicleFairMarketValue__c).maybe(:float)
            optional(:VehicleTypeCode__c).maybe(:string)
            optional(:VehicleUseReason__c).maybe(:string)
            optional(:ZipCode4__c).maybe(:string)
            optional(:ZipCode5__c).maybe(:string)
            optional(:IndividualId__c).maybe(:integer)
            optional(:IsThereAnotherOwnerToggle__c).maybe(:string)
            # attribute :DependentCareProvider__r DependentCareProvider__r.optional.meta(omittable: true)
            # attribute :DependentIndividual__r DependentIndividual__r.optional.meta(omittable: true)
            optional(:DCResourceDetailId__c).maybe(:integer)
          end

          rule(:ChildName__c, :ExpenseTypeCode__c) do
            if key && values[:ExpenseTypeCode__c] == 'Child Support' && values[:ChildName__c].nil?
              key.failure(text: "invalid Child Name - cannot be blank if Expense Type Code is 'Child Support'",
                          error: result.errors.to_h)
            end
          end

          rule(:ChildName__c) do
            if key && value && value.length > 25
              key.failure(text: "invalid Child Name - Only a maximum of 25 characters allowed",
                          error: result.errors.to_h)
            end
          end

          rule(:EndDate__c) do
            if key && value && value > Date.today
              key.failure(text: "invalid End Date - Date should be today or in the past.",
                          error: result.errors.to_h)
            end
          end

          rule(:StartDate__c, :EndDate__c) do
            if key && values[:StartDate__c] && values[:EndDate__c] && values[:EndDate__c] < values[:StartDate__c]
              key.failure(text: "invalid End Date - End Date should be later than Start Date.",
                          error: result.errors.to_h)
            end
          end

          rule(:ExpenseAmount__c) do
            if key && value
              amount_strings = value.to_s.split('.')
              fractional_string = amount_strings.last
              whole_number, fractional = amount_strings.map(&:to_i)
              if fractional_string.length > 2 || whole_number < 0 || whole_number > 9_999_999_999 || fractional < 0 || fractional > 99
                key.failure(text: "invalid Expense Amount - must only have numbers, two decimal places, and have a value between 0 to 9999999999.99",
                            error: result.errors.to_h)
              end
            end
          end

          rule(:PrimaryPhoneNumber__c) do
            if key && value && value.match(/[^\d-]/)
              key.failure(text: "invalid Primary Phone Number - Letters and special characters cannot be input into the field.",
                          error: result.errors.to_h)
            end
          end

          rule(:PrimaryPhoneNumber__c) do
            if (key && value && value.length != 12) && (value[3] != '-' || value[7] != '-')
              key.failure(text: "invalid Primary Phone Number - must be a valid 10-digit number in the following format: “123-456-7890”.",
                          error: result.errors.to_h)
            end
          end

          rule(:StartDate__c) do
            if key && value && value > Date.today
              key.failure(text: "invalid Start Date - Date should be today or in the past.",
                          error: result.errors.to_h)
            end
          end

          rule(:IncomePayFrequency__c, :TotalGrossAmount__c) do
            if key && values[:IncomePayFrequency__c] && values[:TotalGrossAmount__c].nil?
              key.failure(text: "invalid Total Gross Amount - cannot be blank if Income Pay Frequency is present.",
                          error: result.errors.to_h)
            end
          end

          rule(:TotalGrossAmount__c) do
            if key && value && value == 0
              key.failure(text: "invalid Total Gross Amount - Value must not be zero.",
                          error: result.errors.to_h)
            end
          end

          rule(:TotalGrossAmount__c) do
            if key && value
              amount_strings = value.to_s.split('.')
              fractional_string = amount_strings.last
              whole_number, fractional = amount_strings.map(&:to_i)
              if fractional_string.length > 2 || whole_number < 0 || whole_number > 9_999_999_999 || fractional < 0 || fractional > 99
                failure_text = "invalid Total Gross Amount - must only have numbers, two decimal places, and have a value between 0 to 9999999999.99"
                key.failure(text: failure_text,
                            error: result.errors.to_h)
              end
            end
          end
        end
      end
    end
  end
end