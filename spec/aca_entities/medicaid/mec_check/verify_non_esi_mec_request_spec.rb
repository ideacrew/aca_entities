# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mec_check'

RSpec.describe ::AcaEntities::Medicaid::MecCheck::VerifyNonEsiMecRequest do

  let(:required_params) { { non_esi_mec_request: non_esi_mec_request } }

  let(:non_esi_mec_request) { { non_esi_mec_individual_information: non_esi_mec_individual_information } }

  let(:non_esi_mec_individual_information) do
    {
      person_ssn: '666666677',
      person_name: { first_name: 'Bob', last_name: 'McBob' },
      person_date_of_birth: Date.today,
      requested_insurance_period: { start_date: (Time.now - 604_800).to_date, end_date: Date.today },
      organization_code: 'CHIP'
    }
  end

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect { described_class.new }.to raise_error(Dry::Struct::Error, /:first_name is missing in Hash input/)
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
  end
end
