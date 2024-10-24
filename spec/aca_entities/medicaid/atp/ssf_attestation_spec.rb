# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/not_incarcerated_indicator'
require 'aca_entities/medicaid/atp/ssf_attestation'

RSpec.describe ::AcaEntities::Medicaid::Atp::SsfAttestation do

  describe 'with valid arguments' do

    let(:required_params) do
      { non_perjury_indicator: true,
        not_incarcerated_indicators: [{ metadata: nil, value: true }],
        information_changes_indicator: false }
    end

    let(:optional_params) do
      { collections_agreement_indicator: false,
        medicaid_obligations_indicator: false,
        privacy_agreement_indicator: false,
        pending_charges_indicator: false,
        application_terms_indicator: false }
    end

    let(:all_params) { required_params.merge(optional_params) }

    context 'invalid parameters' do
      context 'with empty parameters' do
        it 'should list error for every required parameter' do
          expect { described_class.new }.to raise_error(Dry::Struct::Error, /:non_perjury_indicator is missing in Hash input/)
        end
      end

      context 'with optional parameters only' do
        it 'should list error for every required parameter' do
          expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:non_perjury_indicator is missing in Hash input/)
        end
      end
    end

    context 'valid parameters' do
      context 'with required parameters only' do
        it 'should initialize' do
          expect(described_class.new(required_params)).to be_a described_class
        end

        it 'should not raise error' do
          expect { described_class.new(required_params) }.not_to raise_error
        end
      end

      context 'with all required and optional parameters' do
        it 'should initialize' do
          expect(described_class.new(required_params)).to be_a described_class
        end

        it 'should not raise error' do
          expect { described_class.new(required_params) }.not_to raise_error
        end
      end
    end
  end
end
