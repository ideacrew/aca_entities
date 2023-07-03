# frozen_string_literal: true

require 'spec_helper'

module AcaEntities
  module Eligible
    class StateHistoryExample < Dry::Struct
    end
  end
end

RSpec.describe AcaEntities::Eligible::StateHistory do
  let(:required_params) do
    {
      effective_on: Date.today,
      is_eligible: true,
      from_state: 'draft',
      to_state: 'eligible',
      transition_at: DateTime.now
    }
  end

  let(:optional_params) do
    {
      event: 'mark_eligible',
      comment: 'hc4cc eligibility submitted',
      reason: 'childcare subsidy'
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  subject { AcaEntities::Eligible::StateHistoryExample }

  context 'Initializing with required params' do
    it 'should initialize the entity' do
      result = subject.new(required_params)

      expect(result).to be_a subject
    end
  end

  context 'initializing with additional optional params' do
    it 'should initialize the entity' do
      result = subject.new(all_params)

      expect(result).to be_a subject
    end
  end
end
