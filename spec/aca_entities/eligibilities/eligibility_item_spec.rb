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

  context 'Initializing with all required params' do
    it 'should initialize without error' do
      result = subject.new(required_params)

      expect(result.success).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end
end
