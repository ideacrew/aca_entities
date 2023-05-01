# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Contracts::Enrollments::HbxEnrollmentMemberContract do

  let(:family_member_reference) do
    {
      family_member_hbx_id: '1001',
      first_name: 'first name',
      last_name: 'last name',
      person_hbx_id: '1001',
      is_primary_family_member: true
    }
  end

  let!(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
    }
  end

  let(:required_params) do
    {
      family_member_reference: family_member_reference,
      carrier_member_id: nil,
      premium_amount: currency,
      applied_aptc_amount: currency,
      coverage_end_on: nil,
      is_subscriber: true,
      eligibility_date: Date.today,
      coverage_start_on: Date.today,
      tobacco_use: 'Y',
      non_tobacco_use_premium: non_tobacco_use_premium,
      slcsp_member_premium: currency
    }
  end

  context 'with valid params' do
    let(:non_tobacco_use_premium) do
      {
        cents: 220.0,
        currency_iso: "USD"
      }
    end

    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end
  end

  context 'with invalid valid params' do
    let(:non_tobacco_use_premium) { nil }

    before do
      @result = subject.call(required_params)
    end

    it 'should return failure' do
      expect(@result.failure?).to be_truthy
    end

    it 'should return the validation error' do
      expect(@result.errors[:non_tobacco_use_premium]).to include("non tobacco premium missing")
    end
  end
end
