# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_member__c_builder'

RSpec.describe AcaEntities::Medicaid::Ios::Functions::SspMemberCBuilder, dbclean: :after_each do

  # Consider using data prep plus transform pattern vs builder
  # (hard to spec the context object that builders use, plus they need data prep anyways)

  # should use more recent example payload
  let(:family) do
    # family_json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/simple_L_cv_payload.json"))
    family_json = File.read(Pathname.pwd.join("/Users/michaelkaramanov/Desktop/testing/transfer_test_json.txt"))
    family_hash = JSON.parse(family_json)
    family_hash['family']
  end
  let(:applications) do
    # need to use test payload that has array of applications (as opposed to single hash)
    family['magi_medicaid_applications']
  end

  let(:context) do
    context_hash = { magi_medicaid_applications: applications }
    AcaEntities::Operations::Transforms::Context.new(context_hash)
  end

  subject do
    binding.irb
    described_class.new.call(context)
  end

  context 'with valid cv3 application passed in' do
    it "should return success" do
      expect(subject.success?).to be_truthy
    end
  end
end