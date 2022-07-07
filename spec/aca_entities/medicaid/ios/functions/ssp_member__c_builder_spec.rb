# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_member__c_builder'
require 'aca_entities/medicaid/ios/operations/generate_ios'
require 'aca_entities/medicaid/ios/contracts/ssp_member__c_contract'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspMemberCBuilder, dbclean: :after_each do

  # should use more recent example payload?
  let(:family) do
    json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    prepped_data = AcaEntities::Medicaid::Ios::Operations::GenerateIos.new.send(:prep_data, json).value!
    prepped_data[:family]
  end

  # assuming member data is transformed from FinancialAssistance::Applicant (could also be from Person or FamilyMember)
  let(:application) do
    # need to use test payload that has array of applications (as opposed to single hash, or assume data prep prepares a hash)
    family[:magi_medicaid_applications]
  end

  let(:family_members_hash) do
    family[:family_members_hash]
  end

  let(:context) do
    context_hash = {
      'family.magi_medicaid_applications' => {
        name: 'family.magi_medicaid_applications',
        item: application
      },
      'family.family_members_hash' => {
        name: 'family.family_members_hash',
        item: family_members_hash
      }
    }
    AcaEntities::Operations::Transforms::Context.new(context_hash)
  end

  subject do
    described_class.new.call(context)
  end

  context 'with valid cv3 application in context' do
    it "should return a non-empty array" do
      expect(subject).to be_a(Array)
      expect(subject.length).not_to eq(0)
    end

    it 'should only contain valid SSP_Member__c objects' do
      subject.each do |ssp_member__c|
        result = AcaEntities::Medicaid::Ios::Contracts::SspMemberCContract.new.call(ssp_member__c)
        expect(result.success?).to be_truthy
      end
    end
  end
end