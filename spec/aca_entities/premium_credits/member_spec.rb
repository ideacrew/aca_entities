# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::PremiumCredits::Member, dbclean: :after_each do

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

    let(:optional_params) do
      {
        id: '100',
        end_on: Date.today + 30,
        timestamps: timestamps
      }
    end

    let(:required_params) do
      { kind: 'aptc_eligible',
        value: 'true',
        start_on: Date.today,
        family_member_reference: family_member_reference }
    end

    let(:input_params) { required_params.merge(optional_params) }

    before do
      params = AcaEntities::PremiumCredits::Contracts::MemberContract.new.call(input_params).to_h
      @result = described_class.new(params)
    end

    it 'should return member_premium_credit entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of member_premium_credit' do
      expect(@result.to_h.keys.sort).to eq(input_params.keys.sort)
    end
  end
end
