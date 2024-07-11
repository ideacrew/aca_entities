# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mec_check'

RSpec.describe AcaEntities::Medicaid::MecCheck::Contracts::NonEsiMecRequestContract do

  let(:required_params) { { non_esi_mec_individual_information: non_esi_mec_individual_information } }

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
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context 'with all required and optional parameters' do
    it 'should pass validation' do
      result = subject.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end
end
