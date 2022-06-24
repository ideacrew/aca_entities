# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::PremiumCredits::Contracts::MemberContract,  dbclean: :after_each do
  describe 'initialize' do
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

    let(:all_params) { required_params.merge(optional_params) }

    context 'valid params' do
      let(:required_params) do
        { kind: 'aptc_eligible',
          value: 'true',
          start_on: Date.today,
          family_member_reference: family_member_reference }
      end

      before do
        @result = subject.call(all_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should return all params' do
        expect(@result.to_h).to eq(all_params)
      end
    end

    context 'invalid params' do
      before do
        @result = subject.call({})
      end

      it 'should return failure' do
        expect(@result).to be_failure
      end

      it 'should return a failure with error messages' do
        expect(@result.errors.to_h.keys).to eq(
          [:kind, :value, :start_on, :family_member_reference]
        )
      end
    end

    context 'invalid kind' do
      let(:required_params) do
        { kind: 'kind',
          value: 'true',
          start_on: Date.today,
          family_member_reference: family_member_reference }
      end

      before do
        @result = subject.call(required_params)
      end

      it 'should return a failure with error messages' do
        expect(
          @result.errors.to_h[:kind]
        ).to include('must be one of: aptc_eligible, csr')
      end
    end
  end
end
