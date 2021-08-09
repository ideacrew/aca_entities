# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/lawful_presence_status_eligibility'

RSpec.describe ::AcaEntities::Medicaid::Atp::LawfulPresenceStatusEligibility,  dbclean: :around_each do

  let(:required_params) { { eligibility_indicator: true } }

  let(:optional_params) { {} }

  let(:input_params) { required_params.merge(optional_params)}

  it 'should initialize' do
    expect(described_class.new(input_params)).to be_a described_class
  end

  it 'should not raise error' do
    expect { described_class.new(input_params) }.not_to raise_error
  end

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect { described_class.new }.to raise_error(Dry::Struct::Error, /:eligibility_indicator is missing in Hash input/)
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:eligibility_indicator is missing in Hash input/)
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

