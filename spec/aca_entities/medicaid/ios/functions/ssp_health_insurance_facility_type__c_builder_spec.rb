# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_health_insurance_facility_type__c_builder'
require 'aca_entities/medicaid/ios/operations/generate_ios'
require 'aca_entities/medicaid/ios/contracts/ssp_health_insurance_facility_type__c_contract'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspHealthInsuranceFacilityTypeCBuilder, dbclean: :after_each do

  # should use more recent example payload?
  let(:family) do
    json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    prepped_data = AcaEntities::Medicaid::Ios::Operations::GenerateIos.new.send(:prep_data, json).value!
    prepped_data[:family]
  end

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

    it 'should only contain valid SSP_HealthInsuranceFacilityType__c objects' do
      subject.each do |ssp_health_insurance_facility_type__c|
        result = AcaEntities::Medicaid::Ios::Contracts::SspHealthInsuranceFacilityTypeCContract.new.call(ssp_health_insurance_facility_type__c)
        expect(result.errors).to be_empty
      end
    end

    it 'should contain valid data' do
      result = subject.first
      expect(result).to include(
        'CoverageStartDate__c' => '2021-01-01',
        'FacilityType__c' => 'MD'
      )
    end
  end
end