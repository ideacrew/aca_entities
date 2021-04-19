# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::EnrollmentPeriods::SpecialEnrollmentPeriod, dbclean: :after_each do

  let(:timestamp) do
    {
      submitted_at: Date.today,
      created_at: Date.today,
      modified_at: Date.today
    }
  end

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
      is_valid: nil,
      effective_on_kind: "first_of_next_month",
      effective_on: Date.today,
      submitted_at: Date.today,
      title: "Lost or will soon lose other health insurance ",
      start_on: Date.today,
      end_on: Date.today,
      qle_answer: nil,
      next_poss_effective_date: nil,
      option1_date: nil,
      option2_date: nil,
      option3_date: nil,
      optional_effective_on: [],
      csl_num: nil,
      market_kind: nil,
      admin_flag: nil
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
      expect { described_class.new(input_params.reject { |k, _v| k == :qle_on }) }.to raise_error(Dry::Struct::Error, /:qle_on is missing/)
    end
  end
end







