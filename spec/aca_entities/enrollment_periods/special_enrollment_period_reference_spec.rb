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
    before do
      sep_params = AcaEntities::Contracts::EnrollmentPeriods::SpecialEnrollmentPeriodReferenceContract.new.call(input_params).to_h
      @result = described_class.new(sep_params)
    end

    it 'should initialize' do
      expect(@result).to be_a(described_class)
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end

    context 'without any params' do
      let(:input_params) { {} }

      it "returns an instance of the #{described_class}" do
        expect(@result).to be_a(described_class)
      end
    end
  end
end
