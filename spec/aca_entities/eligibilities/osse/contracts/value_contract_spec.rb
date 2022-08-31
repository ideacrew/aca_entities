# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Osse::Contracts::ValueContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:key) { 'OsseBenefitSponsorGrant' }
  let(:title) { 'Employer Contribution' }
  let(:description) { 'Osse Eligibility - Employer Contribution' }

  let(:required_params) do
    {
      key: key,
      title: title
    }
  end
  let(:optional_params) do
    {
      description: description
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with no params' do
    let(:error_message) do
      { key: ['is missing'], title: ['is missing'] }
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
