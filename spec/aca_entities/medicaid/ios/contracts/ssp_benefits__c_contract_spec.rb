# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::SspBenefitsCContract, dbclean: :after_each do

  let(:required_params) do
    {
      BeginDate__c: Date.today # OverlappingMedicareCoverageValidator, , RequiredValidator
    }
  end

  let(:optional_params) do
    {
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
      EndDate__c: Date.today, # OverlappingMedicareCoverageValidator, EndDateStartDateValidator
      State__c: "State",
      StatusofApplication__c: "Status of Application",
      HasMedicareCoverageButNoInfo__c: false,
      RecordType: {},
      SSP_Member__r: {}
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

    context 'invalid begin date' do
      context 'with begin date in the future' do
        it 'should fail validation' do
          all_params[:BeginDate__c] = Date.today + 1
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