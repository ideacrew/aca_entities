# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/date'
require 'aca_entities/medicaid/atp/signature_date'
require 'aca_entities/medicaid/atp/signature_name'
require 'aca_entities/medicaid/atp/signature'

RSpec.describe ::AcaEntities::Medicaid::Atp::Signature,  dbclean: :around_each do

  describe 'with valid arguments' do

    let(:required_params) do
      {
        signature_date: { date: Date.today }
      }
    end

    let(:optional_params) do
      {
        signature_name:
        {
          full: "Full Name"
        }
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
          expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:signature_date is missing in Hash input/)
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