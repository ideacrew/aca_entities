# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/contact_builder'
require 'aca_entities/medicaid/ios/operations/generate_ios'
require 'aca_entities/medicaid/ios/contracts/contact_contract'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::ContactBuilder, dbclean: :after_each do

  # should use more recent example payload?
  let(:family) do
    json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    prepped_data = AcaEntities::Medicaid::Ios::Operations::GenerateIos.new.send(:prep_data, json).value!
    prepped_data[:family]
  end

  # assuming contact data is transformed from something in cv3 application
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
      expect(subject.length).to eq(1)
    end

    it 'should only contain valid contact objects' do
      subject.each do |contact|
        result = AcaEntities::Medicaid::Ios::Contracts::ContactContract.new.call(contact)
        expect(result.success?).to be_truthy
      end
    end

    it 'should contain valid data' do
      result = subject.first
      expect(result).to include(
        'Birthdate' => '1960-01-01',
        'FirstName' => 'Rob',
        'Email' => 'robsmith@test.com'
      )
    end

  end
end