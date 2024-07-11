# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe ::AcaEntities::InsurancePolicies::Member do
  include_context('insurance_policies_context')

  let(:input_params) do
    contract_holder
  end

  let(:member_params) do
    AcaEntities::InsurancePolicies::Contracts::MemberContract.new.call(input_params)
  end

  describe 'with valid arguments' do
    it 'validates input params with contract' do
      expect(member_params.success?).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(member_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(member_params.to_h) }.not_to raise_error
    end
  end
end
