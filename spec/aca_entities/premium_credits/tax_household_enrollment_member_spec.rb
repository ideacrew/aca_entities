# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::PremiumCredits::TaxHouseholdEnrollmentMember, dbclean: :after_each do

  let(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
    }
  end

  let(:hbx_enrollment_member_reference) do
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

  let(:tax_household_member_reference) do
    {
      is_subscriber: true,
      reason: nil
    }
  end

  let(:input_params) do
    {
      hbx_enrollment_member_id: hbx_enrollment_member_reference,
      tax_household_member_id: tax_household_member_reference,
      member_ehb_benchmark_health_premium: currency,
      member_ehb_benchmark_dental_premium: currency,
      age_on_effective_date: '25'
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
                              k == :hbx_enrollment_member_id
                            end)
      end.to raise_error(Dry::Struct::Error, /:hbx_enrollment_member_id is missing/)
    end
  end
end
