# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::EligibilityItemContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:id) { '5255488' }
  let(:key) { :aptc_csr_eligibility }
  let(:title) { 'APTC/CSR Credit' }
  let(:description) do
    'ACA Advance Premium Tax Credit and Cost Sharing Reduction Benefit'
  end
  let(:evidence_items) { aptc_evidence_items }
  let(:published_at) { now }
  let(:tags) { %w[aca credit faa] }

  let(:required_params) { { key: key, evidence_items: evidence_items } }
  let(:optional_params) do
    {
      id: id,
      key: key,
      title: title,
      description: description,
      tags: tags,
      published_at: published_at
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with no params' do
    let(:error_message) do
      { key: ['is missing'], evidence_items: ['is missing'] }
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
