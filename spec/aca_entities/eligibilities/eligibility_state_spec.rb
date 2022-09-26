# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::EligibilityState do
  include_context 'eligibilities_shared_context'
  subject { described_class }

  let(:id) { 'zxy765' }
  let(:eligibility_item_key) { 'aptc_csr_eligibility' }
  let(:is_eligible) { false }
  let(:earliest_due_date) { five_days_from_today }
  let(:determined_at) { now }
  let(:evidence_states) { evidence_states_undetermined }

  let(:required_params) do
    {
      eligibility_item_key: eligibility_item_key,
      is_eligible: is_eligible,
      evidence_states: evidence_states,
      earliest_due_date: earliest_due_date,
      determined_at: determined_at
    }
  end

  let(:optional_params) { { id: id } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Initializing with required params' do
    it 'should initialize the entity' do
      result = described_class.new(required_params)

      expect(result).to be_a described_class
    end
  end

  context 'initializing with additional optional params' do
    let(:required_params) do
      {
        eligibility_item_key: eligibility_item_key,
        is_eligible: is_eligible,
        evidence_states: evidence_states,
        earliest_due_date: earliest_due_date,
        determined_at: determined_at,
        start_on: five_days_from_today,
        end_on: Date.today.next_month
      }
    end

    it 'should initialize the entity' do
      result = described_class.new(required_params)

      expect(result).to be_a described_class
    end
  end
end
