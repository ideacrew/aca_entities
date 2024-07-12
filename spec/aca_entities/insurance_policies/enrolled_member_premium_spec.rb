# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe ::AcaEntities::InsurancePolicies::EnrolledMemberPremium do
  include_context('insurance_policies_context')

  let(:input_params) do
    {
      premium_schedule: premium_schedule,
      insurance_rate: { cents: 54_522.0, currency_iso: "USD" }
    }
  end

  let(:enrolled_member_premium_params) do
    AcaEntities::InsurancePolicies::Contracts::EnrolledMemberPremiumContract.new.call(input_params)
  end

  describe 'with valid arguments' do
    it 'validates input params with contract' do
      expect(enrolled_member_premium_params.success?).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(enrolled_member_premium_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(enrolled_member_premium_params.to_h) }.not_to raise_error
    end
  end
end
