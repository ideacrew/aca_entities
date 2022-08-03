# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::GrantContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:premium_adjustment_grant) { 'employer_contribution' }
  let(:subject) { 'Employer Contribution' }
  let(:value) { 0.8 }
  let(:start_on) { five_days_from_today }
  let(:end_on) { Date.today.next_month }

  let(:required_params) do
    {
      premium_adjustment_grant: premium_adjustment_grant,
      value: value,
      start_on: start_on,
      end_on: end_on
    }
  end
  let(:optional_params) do
    {
      subject: subject
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with no params' do
    let(:error_message) do
      { end_on: ['is missing'], start_on: ['is missing'], value: ['is missing'], premium_adjustment_grant: ['is missing'] }
    end

    it 'should fail validation' do
      result = described_class.new.call({})

      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)

      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = described_class.new.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end
end
