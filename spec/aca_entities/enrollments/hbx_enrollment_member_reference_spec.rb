# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Enrollments::HbxEnrollmentMemberReference, dbclean: :after_each do

  let(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
    }
  end

  let(:input_params) do
    {
      is_subscriber: true,
      premium_amount: currency,
      applied_aptc_amount: currency,
      eligibility_date: Date.today,
      coverage_start_on: Date.today,
      coverage_end_on: nil,
      tobacco_use: 'no'
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
          k == :is_subscriber
        end)
      end.to raise_error(Dry::Struct::Error, /:is_subscriber is missing/)
    end
  end
end
