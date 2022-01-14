# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligibilities::Contracts::EvidenceItemContract do
  subject { described_class.new }

  let(:id) { '52854' }
  let(:key) { :vlp_evidence }
  let(:title) { 'Verification of Lawful Presence Evidence' }
  let(:description) do
    'Evidence that a person is a qualified immigrants or other non-U.S. citizens who has ave permission to live or work in the U.S.'
  end

  let(:subject_ref) { URI('gid://enroll_app/Family::FamilyMember') }
  let(:evidence_ref) { URI('gid://enroll_app/ConsumerRole') }

  let(:optional_params) { { id: id, title: title, description: description } }
  let(:required_params) do
    { key: key, subject_ref: subject_ref, evidence_ref: evidence_ref }
  end
  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        key: ['is missing'],
        subject_ref: ['is missing'],
        evidence_ref: ['is missing']
      }
    end

    it 'should fail validation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = described_class.new.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end
end
