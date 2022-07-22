# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_application__c_builder'
require 'aca_entities/medicaid/ios/operations/generate_ios'
require 'aca_entities/medicaid/ios/contracts/ssp_application__c_contract'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspApplicationCBuilder, dbclean: :after_each do

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

  subject do
    described_class.new.call(context)
  end

  context 'with valid cv3 application in context' do

    it 'should conform to the SSP_Application__c contract' do
      result = AcaEntities::Medicaid::Ios::Contracts::SspApplicationCContract.new.call(subject)
      expect(result.success?).to be_truthy
    end
  end

end