# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe ::AcaEntities::InsurancePolicies::Enrollment do
  include_context('insurance_policies_context')

  let(:currency) do
    {
      cents: 98_700.0,
      currency_iso: "USD"
    }
  end

  let(:family_member_reference) do
    {
      family_member_hbx_id: "1234567",
      relation_with_primary: "self"
    }
  end

  let(:tax_household_member) do
    {
      family_member_reference: family_member_reference,
      is_subscriber: true,
      tax_filer_status: "tax_filer"
    }
  end

  let(:tax_household) do
    {
      hbx_id: "207600",
      tax_household_members: [tax_household_member]
    }
  end

  let(:enrollment) do
    {
      subscriber: enrollment_subscriber,
      dependents: enrollment_dependents,
      tax_households: [tax_household],
      total_premium_amount: currency,
      total_premium_adjustment_amount: currency,
      start_on: january_1
    }
  end

  let(:input_params) do
    enrollment
  end

  let(:enrollment_params) do
    AcaEntities::InsurancePolicies::Contracts::EnrollmentContract.new.call(input_params)
  end

  describe 'with valid arguments' do
    it 'validates input params with contract' do
      expect(enrollment_params.success?).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(enrollment_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(enrollment_params.to_h) }.not_to raise_error
    end
  end
end
