# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mec_check'

RSpec.describe ::AcaEntities::Medicaid::MecCheck::NonEsiMecIndividualInformation, dbclean: :after_each do

  let(:required_params) do
    {
      person_name: { first_name: 'Bob', last_name: 'McBob' },
      person_date_of_birth: Date.parse("01/01/2010"),
      requested_insurance_period: { start_date: (Time.now - 604_800).to_date, end_date: Date.today },
      organization_code: 'CHIP'
    }
  end

  let(:optional_params) do
    {
      person_ssn: '666666677',
      person_sex_code: 'M'
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect { described_class.new }.to raise_error(Dry::Struct::Error, /:first_name is missing in Hash input/)
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:person_name is missing in Hash input/)
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
        expect(described_class.new(all_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(all_params) }.not_to raise_error
      end
    end
  end
end
