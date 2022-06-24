# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::PremiumCredits::Group, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:family_member_reference) do
      { family_member_hbx_id: '1001',
        first_name: 'first name',
        last_name: 'last name',
        person_hbx_id: '1001',
        is_primary_family_member: true }
    end

    let(:timestamps) do
      { submitted_at: DateTime.now,
        created_at: DateTime.now,
        modified_at: DateTime.now }
    end

    let(:member) do
      {
        kind: 'aptc_eligible',
        value: 'true',
        start_on: Date.today,
        family_member_reference: family_member_reference,
        id: '100',
        end_on: Date.today + 30,
        timestamps: timestamps
      }
    end

    let(:optional_params) do
      {
        id: '10',
        authority_determination_reference: { identifier: '10', label: 'FinancialAssistance::Application' },
        premium_credit_monthly_cap: '300.08',
        sub_group_reference: { identifier: '100', label: 'FinancialAssistance::EligibilityDetermination' },
        expected_contribution_percentage: 0.0316,
        end_on: Date.today + 30,
        timestamps: timestamps
      }
    end

    let(:required_params) do
      { kind: 'aptc_csr', start_on: Date.today, members: [member] }
    end

    let(:input_params) { required_params.merge(optional_params) }

    before do
      params = AcaEntities::PremiumCredits::Contracts::GroupContract.new.call(input_params).to_h
      @result = described_class.new(params)
    end

    it 'should return group_premium_credit entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of group_premium_credit' do
      expect(@result.to_h.keys.sort).to eq(input_params.keys.sort)
    end

    it 'should match all the input keys of member_premium_credit' do
      expect(@result.to_h[:members].first.keys.sort).to eq(member.keys.sort)
    end
  end
end
