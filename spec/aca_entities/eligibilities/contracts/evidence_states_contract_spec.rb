# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::EvidenceStatesContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:evidence_state) { { esi_evidence: {} } }
  let(:evidence_states) { { evidence_states: evidence_state } }

  context 'Given a evidence_states key' do
    it 'should validate' do
      expect(subject.call(evidence_states)).to be_truthy
    end
  end
end
