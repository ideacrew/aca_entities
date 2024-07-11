# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/role_of_person_reference'
require 'aca_entities/medicaid/atp/signature_date'
require 'aca_entities/medicaid/atp/signature_name'
require 'aca_entities/medicaid/atp/signature'
require 'aca_entities/medicaid/atp/authorized_representative_reference'
require 'aca_entities/medicaid/atp/not_incarcerated_indicator'
require "aca_entities/medicaid/atp/ssf_signer_authorized_representative_association"
require 'aca_entities/medicaid/atp/ssf_attestation'
require 'aca_entities/medicaid/atp/ssf_signer'

RSpec.describe ::AcaEntities::Medicaid::Atp::SsfSigner do

  describe 'with valid arguments' do

    let(:required_params) { { role_reference: { ref: "a-person-id" } } }

    let(:optional_params) do
      { signature: signature,
        ssf_attestation: ssf_attestation,
        ssf_signer_authorized_representative_association: {
          signature: signature,
          authorized_representative_reference: { ref: "another-person-id" }
        } }
    end

    let(:ssf_attestation) do
      {
        non_perjury_indicator: true,
        not_incarcerated_indicators: [{ metadata: nil, value: true }],
        information_changes_indicator: false
      }
    end

    let(:signature) do
      {
        signature_date: { date: DateTime.now.to_date }
      }
    end

    let(:all_params) { required_params.merge(optional_params)}

    context 'invalid parameters' do
      context 'with empty parameters' do
        it 'should list error for every required parameter' do
          expect { described_class.new }.to raise_error(Dry::Struct::Error, /:ref is missing in Hash input/)
        end
      end

      context 'with optional parameters only' do
        it 'should list error for every required parameter' do
          expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:role_reference is missing in Hash input/)
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
