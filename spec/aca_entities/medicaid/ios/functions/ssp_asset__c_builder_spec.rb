# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_asset__c_builder'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspAssetCBuilder, dbclean: :after_each do

  # should use more recent example payload?
  let(:family) do
    family_json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    family_hash = JSON.parse(family_json)
    family_hash['family']
  end

  # assuming asset data is transformed from something in cv3 Application (likely need to pass in something nested inside application)
  let(:application) do
    # need to use test payload that has array of applications (as opposed to single hash, or assume data prep prepares a hash)
    family['magi_medicaid_applications']
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
        expect(result).to be_truthy
      end
    end
  end
end