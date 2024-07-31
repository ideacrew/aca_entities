# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Determinations::IndividualMarketTransition do

  let!(:input_params) do
    {
      role_type: "consumer",
      start_on: Date.today,
      end_on: Date.today,
      reason_code: "initial_individual_market_transition_created_using_data_migration",
      submitted_at: DateTime.now
    }

  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(input_params.reject { |k, _v| k == :reason_code }) }.to raise_error(Dry::Struct::Error, /:reason_code is missing/)
    end
  end
end
