# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::AptcCsrEligibilitiesEnrollments::AptcAccumulator, dbclean: :after_each do

  let(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
    }
  end

  let(:family_member_reference) do
    {
      family_member_hbx_id: '1001',
      first_name: 'first name',
      last_name: 'last name',
      person_hbx_id: '1001',
      is_primary_family_member: true
    }
  end

  let(:enrollment_params) do
    {
      hbx_id: '11223344',
      effective_on: Date.today,
      aasm_state: 'coverage_selected',
      is_active: true,
      market_place_kind: 'individual',
      enrollment_period_kind: 'open_enrollment',
      product_kind: 'health'
    }
  end

  let(:enrolled_member_params) do
    {
      family_member_reference: family_member_reference,
      carrier_member_id: nil,
      premium_amount: currency,
      applied_aptc_amount: currency,
      coverage_end_on: nil,
      is_subscriber: true,
      eligibility_date: Date.today,
      coverage_start_on: Date.today
    }
  end

  let(:start_on) { Date.today }
  let(:end_on) {  Date.today }

  let(:accumulator_adjustment) do
    {
      enrollment: enrollment_params,
      enrolled_member: enrolled_member_params,
      start_on: start_on,
      end_on: end_on,
      amount: 1000
    }
  end

  let(:input_params) do
    {
      maximum_amount: 1000,
      balance: 500,
      accumulator_adjustments: [accumulator_adjustment]
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
end