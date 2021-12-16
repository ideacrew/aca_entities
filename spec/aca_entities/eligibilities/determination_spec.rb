# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Determination do
  include_context 'eligibilities_shared_context'
  subject { described_class }

  let(:id) { '5255488' }
  let(:status) { 'verification_outstanding' }
  let(:evidence_states) { { evidence_states: {} } }
  let(:earliest_due_date) { five_days_from_today }
  let(:determined_at) { now }

  let(:required_params) do
    {
      status: status,
      evidence_states: evidence_states,
      earliest_due_date: earliest_due_date,
      determined_at: determined_at
    }
  end

  let(:all_params) { required_params }

  context 'Initializing with required params' do
    it 'should pass initialize' do
      result = described_class.new(required_params)

      expect(result).to be_a described_class
    end
  end
end
