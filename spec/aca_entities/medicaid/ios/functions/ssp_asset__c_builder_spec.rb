# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_asset__c_builder'
require 'aca_entities/medicaid/ios/operations/generate_ios'
require 'aca_entities/medicaid/ios/contracts/ssp_asset__c_contract'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspAssetCBuilder, dbclean: :after_each do

  # should use more recent example payload?
  let(:family) do
    json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    prepped_data = AcaEntities::Medicaid::Ios::Operations::GenerateIos.new.send(:prep_data, json).value!
    prepped_data[:family]
  end

  # assuming asset data is transformed from something in cv3 Application (likely need to pass in something nested inside application)
  let(:application) do
    # need to use test payload that has array of applications (as opposed to single hash, or assume data prep prepares a hash)
    family[:magi_medicaid_applications]
  end

  let(:context) do
    context_hash = { 'family.magi_medicaid_applications' => {
      name: 'family.magi_medicaid_applications',
      item: application
    } }
    AcaEntities::Operations::Transforms::Context.new(context_hash)
  end

  subject do
    described_class.new.call(context)
  end

  context 'with valid cv3 application in context' do
    it "should return an array" do
      expect(subject).to be_a(Array)
    end

    it 'should only contain valid SSP_Asset__c objects' do
      subject.each do |ssp_asset__c|
        result = AcaEntities::Medicaid::Ios::Contracts::SspAssetCContract.new.call(ssp_asset__c)
        expect(result.errors).to be_empty
      end
    end

    it 'should contain valid income data' do
      result = subject[0]
      expect(result).to include(
        "EmployerName__c" => "Test LLC",
        'IncomeTypeCode__c' => 'JOBINCOMETYPE',
        'IncomePayFrequency__c' => 'Annually',
        'TotalGrossAmount__c' => 75_000.0
      )
    end
  end

  it 'should contain valid expense data' do
    result = subject[6]
    expect(result).to include(
      'ExpenseTypeCode__c' => 'ALIMONY',
      'ExpenseFrequencyCode__c' => 'Monthly',
      'ExpenseAmount__c' => 700.0
    )
  end
end