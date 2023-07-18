# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::People::IvlOsseEligibility::Grant do
  let(:key) { :contribution_grant }
  let(:title) { 'childcare subsidy contribution' }
  let(:value) { AcaEntities::Eligible::Value.new(title: title, key: key) }
  let(:description) { 'childcare subsidy contribution grant' }
  let(:history_params) do
    {
      effective_on: Date.today,
      is_eligible: true,
      from_state: 'draft',
      to_state: 'eligible',
      transition_at: DateTime.now
    }
  end

  let(:state_histories) do
    [AcaEntities::Eligible::StateHistory.new(history_params)]
  end

  let(:required_params) do
    { key: key, title: title, value: value, state_histories: state_histories }
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
