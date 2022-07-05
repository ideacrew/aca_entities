# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_member__c_builder'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspMemberCBuilder, dbclean: :after_each do

  # should use more recent example payload?
  let(:family) do
    family_json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    family_hash = JSON.parse(family_json)
    family_hash['family']
  end

  # assuming member data is transformed from FinancialAssistance::Applicant (could also be from Person or FamilyMember)
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
  end
end