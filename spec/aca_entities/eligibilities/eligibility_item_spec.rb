# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::EligibilityItem do
  include_context 'eligibilities_shared_context'
  subject { described_class }

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

  context 'Initializing with required params' do
    it 'should initialize without error' do
      expect(subject.new(required_params)).to be_a described_class
      expect(subject.new(required_params).to_h[:key]).to eq key.to_s
    end
  end

  context 'Initializing with all params' do
    let(:compare_params) do
      {
        id: id,
        key: key.to_s,
        title: title,
        description: description,
        tags: tags,
        published_at: published_at
      }
    end

    it 'should initialize without error' do
      expect(subject.new(all_params)).to be_a described_class
      expect(
        subject.new(all_params).to_h.tap { |h| h.delete(:evidence_items) }
      ).to eq compare_params
    end
  end
end
