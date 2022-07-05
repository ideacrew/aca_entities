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

  # assuming asset data is transformed from something in Application (likely need to pass in something nested inside application)
  let(:applications) do
    # need to use test payload that has array of applications (as opposed to single hash, or assume data prep prepares a hash)
    family['magi_medicaid_applications']
  end

  let(:context) do
    context_hash = { 'family.magi_medicaid_applications' => {
      name: 'family.magi_medicaid_applications',
      item: applications
    } }
    AcaEntities::Operations::Transforms::Context.new(context_hash)
  end

  subject do
    described_class.new.call(context)
  end

  context 'with valid cv3 application(???) passed in' do
    it "should return an array" do
      expect(subject).to be_a(Array)
    end
  end
end