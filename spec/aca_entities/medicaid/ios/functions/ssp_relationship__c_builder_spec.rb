# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_relationship__c_builder'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspRelationshipCBuilder, dbclean: :after_each do

  # should use more recent example payload?
  let(:family) do
    family_json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    family_hash = JSON.parse(family_json)
    family_hash['family']
  end

  let(:application) do
    # need to use test payload that has array of applications (as opposed to single hash, or assume data prep prepares a hash)
    family['magi_medicaid_applications']
  end

  let(:family_members) do
# simulate data prep
    family['family_members'].each_with_object({}) do |family_member, member_hash|
        member_hash[family_member['hbx_id']] = family_member
    end
  end

  let(:context) do
    context_hash = {
      'family.magi_medicaid_applications' => {
        name: 'family.magi_medicaid_applications',
        item: application
      },
      'family.family_members' => {
        name: 'family.family_members',
        item: family_members
      }
    }
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