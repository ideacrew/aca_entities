# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::EnrollmentPeriods::SpecialEnrollmentPeriodReference, dbclean: :after_each do

  let(:qualifying_life_event_kind_reference) do
    {
      start_on: Date.today,
      title: 'test title',
      reason: 'test reason',
      market_kind: 'individual'
    }
  end

  let(:input_params) do
    {
      qualifying_life_event_kind_reference: qualifying_life_event_kind_reference,
      qle_on: Date.today,
      start_on: Date.today,
      end_on: Date.today, submitted_at: Date.today, effective_on: Date.today
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
      expect do
        described_class.new(input_params.reject do |k, _v|
                              k == :qualifying_life_event_kind_reference
                            end)
      end.to raise_error(Dry::Struct::Error, /:qualifying_life_event_kind_reference is missing/)
    end
  end
end


