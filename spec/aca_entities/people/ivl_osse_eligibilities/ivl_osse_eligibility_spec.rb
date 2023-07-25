# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::People::IvlOsseEligibilities::IvlOsseEligibility do
  let(:key) { :hc4cc }
  let(:title) { 'childcare subsidy' }
  let(:description) { 'childcare subsidy eligibility' }
  let(:history_params) do
    {
      effective_on: Date.today,
      is_eligible: true,
      from_state: :draft,
      to_state: :eligible,
      event: :move_to_eligible,
      transition_at: DateTime.now
    }
  end

  let(:state_histories) do
    [AcaEntities::Eligible::StateHistory.new(history_params)]
  end

  let(:required_params) do
    { key: key, title: title, state_histories: state_histories }
  end

  let(:optional_params) { { description: description } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Initializing with required params' do
    it 'should initialize the entity' do
      result = described_class.new(required_params)

      expect(result).to be_a described_class
    end
  end

  context 'initializing with additional optional params' do
    it 'should initialize the entity' do
      result = described_class.new(all_params)

      expect(result).to be_a described_class
    end
  end
end
