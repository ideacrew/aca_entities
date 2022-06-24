# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SspAssetCContract, dbclean: :after_each do

  let(:all_params) do
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
      StartDate__c: Date.today, # RequiredValidator
      StateCode__c: "State Code",
      Tips__c: 1.00,
      TotalGrossAmount__c: 1.00,  # CurrencyValidator
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
      #  :DependentCareProvider__r, DependentCareProvider__r.optional.meta(omittable: true)
      #  :DependentIndividual__r, DependentIndividual__r.optional.meta(omittable: true)
      DCResourceDetailId__c: 12_345

      # End_Date_Of_Employment__c, WasDivorceAgreementDateBefore2019__c
    }
  end

  context 'invalid parameters' do
    context 'with incorrect data type' do
      it 'should list error for every bad parameter' do
        bad_params = { SSP_Member__c: 0 }
        expect(subject.call(bad_params).errors.to_h.keys).to match_array bad_params.keys
      end
    end

    # add examples to test validation rules
    context 'invalid child name' do
      context 'with expense type as Child Support and child name missing' do
        it 'should fail validation' do
          all_params[:ChildName__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with child name longer than 25 characters' do
        it 'should fail validation' do
          all_params[:ChildName__c] = 'This Child Name is longer than 25 characters'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid end date' do
      context 'with end date in the future' do
        it 'should fail validation' do
          all_params[:EndDate__c] = Date.today + 1
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with end date earlier than start date' do
        it 'should fail validation' do
          all_params[:EndDate__c] = Date.today - 1
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid expense amount' do
      context 'with more than 2 decimal places in amount' do
        it 'should fail validation' do
          all_params[:ExpenseAmount__c] = 1.111111
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with value greater than 9999999999.99' do
        it 'should fail validation' do
          all_params[:ExpenseAmount__c] = 11_111_111_111_111
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid primary phone number' do
      context 'with invalid characters' do
        it 'should fail validation' do
          all_params[:PrimaryPhoneNumber__c] = '!23-4S6-7890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with invalid length' do
        it 'should fail validation' do
          all_params[:PrimaryPhoneNumber__c] = '456-7890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with invalid format' do
        it 'should fail validation' do
          all_params[:PrimaryPhoneNumber__c] = '1234567890'
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid start date' do
      context 'with start date in the future' do
        it 'should fail validation' do
          all_params[:ExpenseTypeCode__c] = nil
          all_params[:EndDate__c] = nil
          all_params[:StartDate__c] = Date.today + 1
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end
    end

    context 'invalid total gross amount' do
      context 'with income frequency present and total gross amount missing' do
        it 'should fail validation' do
          all_params[:TotalGrossAmount__c] = nil
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with total gross amount of 0' do
        it 'should fail validation' do
          all_params[:TotalGrossAmount__c] = 0.00
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with more than 2 decimal places in amount' do
        it 'should fail validation' do
          all_params[:TotalGrossAmount__c] = 1.111111
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
      end

      context 'with value greater than 9999999999.99' do
        it 'should fail validation' do
          all_params[:TotalGrossAmount__c] = 11_111_111_111_111
          result = subject.call(all_params)
          expect(result.success?).to be_falsey
        end
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