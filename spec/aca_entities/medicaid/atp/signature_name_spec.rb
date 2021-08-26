# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/signature_name'

RSpec.describe ::AcaEntities::Medicaid::Atp::SignatureName,  dbclean: :around_each do

  describe 'with valid arguments' do

    let(:required_params) { {} }

    let(:optional_params) do
      {
        given: 'first',
        middle: 'middle',
        sur: 'last',
        full: 'prefix first middle last suffix'
      }
    end

    let(:all_params) { required_params.merge(optional_params) }

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end

    context 'with only optional parameters' do
      it 'should contain all optional keys and values' do
        result = described_class.new(optional_params)
        expect(result.to_h).to eq optional_params
      end
    end
  end
end

