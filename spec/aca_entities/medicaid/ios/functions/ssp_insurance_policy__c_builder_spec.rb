# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_insurance_policy__c_builder'
require 'aca_entities/medicaid/ios/operations/generate_ios'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspInsurancePolicyCBuilder do

  let(:family) do
    json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    prepped_data = AcaEntities::Medicaid::Ios::Operations::GenerateIos.new.send(:prep_data, json).value!
    prepped_data[:family]
  end

  let(:application) do
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

    it 'should only contain valid SSP_InsurancePolicy__c objects' do
      subject.each do |ssp_insurance_policy__c|
        result = AcaEntities::Medicaid::Ios::Contracts::SspInsurancePolicyCContract.new.call(ssp_insurance_policy__c)
        expect(result.errors).to be_empty
      end
    end

    it 'should contain valid data' do
      result = subject.first
      expect(result).to include(
        'EmployerName__c' => 'test llc',
        'EnrollmentTierLevel__c' => 'N',
        'Is_this_an_empl__c' => "N",
        'PolicyBeginDate__c' => "2021-01-01",
        "IsEnrolledInInsurance__c" => "Y"
      )
    end

  end
end
