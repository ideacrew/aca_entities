# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/authorized_representative_reference'
require 'aca_entities/medicaid/atp/signature_name'
require 'aca_entities/medicaid/atp/signature_date'
require 'aca_entities/medicaid/atp/signature'
require 'aca_entities/medicaid/atp/ssf_signer_authorized_representative_association'

RSpec.describe ::AcaEntities::Medicaid::Atp::SsfSignerAuthorizedRepresentativeAssociation do

  describe 'with valid arguments' do

    let(:required_params) do
      {
        signature: { signature_date: { date: DateTime.now.to_date } }
      }
    end

    let(:optional_params) do
      {
        authorized_representative_reference: { ref: "pe123" }
      }
    end

    let(:all_params) { required_params.merge(optional_params) }

    context 'invalid parameters' do
      context 'with empty parameters' do
        it 'should list error for every required parameter' do
          expect { described_class.new }.to raise_error(Dry::Struct::Error, /:date is missing in Hash input/)
        end
      end

      context 'with optional parameters only' do
        it 'should list error for every required parameter' do
          expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:signature is missing in Hash input/)
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
