# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::EvidenceState do
  include_context 'eligibilities_shared_context'
  subject { described_class }

  let(:evidence_gid) do
    URI(
      'gid://enroll_app/FinancialAssistance::Application/676767/Applicant/55555'
    )
  end

  let(:state) { 'determined' }
  let(:is_satisfied) { false }
  let(:verification_outstanding) { true }
  let(:due_on) { Date.today + 1 }
  let(:visited_at) { DateTime.now }

  let(:optional_params) { {} }

  let(:required_params) do
    {
      evidence_gid: evidence_gid,
      visited_at: visited_at,
      state: state,
      is_satisfied: is_satisfied,
      verification_outstanding: verification_outstanding,
      due_on: due_on
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Initializing with required params' do
    it 'should initialize without error' do
      result = subject.new(required_params)
      expect(result).to be_a described_class
      expect(result.to_h).to eq required_params.merge(
           evidence_gid: evidence_gid.to_s
         )
    end
  end

  context 'Initializing with all params' do
    it 'should initialize without error' do
      expect(subject.new(all_params)).to be_a described_class
      expect(subject.new(all_params).to_h).to eq all_params.merge(
           evidence_gid: evidence_gid.to_s
         )
    end
  end
end
