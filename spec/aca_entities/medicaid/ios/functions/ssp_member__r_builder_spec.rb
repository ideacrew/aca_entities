# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_member__r_builder'
require 'aca_entities/medicaid/ios/contracts/ssp_member__r_contract'
require 'aca_entities/medicaid/ios/operations/generate_ios'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspMemberRBuilder do

  # should use more recent example payload?
  let(:family) do
    json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    prepped_data = AcaEntities::Medicaid::Ios::Operations::GenerateIos.new.send(:prep_data, json).value!
    prepped_data[:family]
  end

  # assuming application individual data is transformed from ::FinancialAssistance::Applicant
  let(:application) do
    # need to use test payload that has array of applications (as opposed to single hash, or assume data prep prepares a hash)
    family[:magi_medicaid_applications]
  end

  let(:context) do
    context_hash = { 'family' => {
      name: 'family.magi_medicaid_applications',
      item: application
    } }
    AcaEntities::Operations::Transforms::Context.new(context_hash)
  end

  context 'with valid cv3 application in context' do
    it 'should conform to the SSP_Member__r contract' do
      result = described_class.new.call(application[:applicants].first)
      contract = AcaEntities::Medicaid::Ios::Contracts::SspMemberRContract.new.call(result)
      expect(contract.errors).to be_empty
    end

    it 'should return valid hispanic data' do
      result = described_class.new.call(application[:applicants][1])
      expect(result[:IsHispanicLatinoSpanishToggle__c]).to eq 'Y'
    end

    it 'should return valid indian tribe data' do
      result = described_class.new.call(application[:applicants][2])
      expect(result[:IsIntendToResideToggle__c]).to eq 'Y'
    end

  end

end
