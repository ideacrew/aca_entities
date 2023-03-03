# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/pay_now/care_first'

RSpec.describe ::AcaEntities::PayNow::CareFirst::Contracts::CoverageKindContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    { coverage_kind: 'urn:openhbx:terms:v1:qhp_benefit_coverage#health' }
  end
  let(:all_params) do
    required_params.merge(optional_params)
  end
  let(:invalid_params) do
    { bad_key: 'bad_val' }
  end

  context 'valid parameters' do
    context 'with required and optional parameters' do
      it 'should initialize' do
        expect(described_class.new(all_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(all_params) }.not_to raise_error
      end
    end
  end
end
