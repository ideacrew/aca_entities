# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::QualifyingLifeEvents::QualifyingLifeEventKindReference do

  let(:input_params) do
    {
      start_on: Date.today,
      title: 'test title',
      reason: 'test reason',
      market_kind: 'individual'
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
      expect { described_class.new(input_params.reject { |k, _v| k == :reason }) }.to raise_error(Dry::Struct::Error, /:reason is missing/)
    end
  end
end
