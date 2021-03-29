# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/contracts/demographic_contract'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::DemographicContract,  dbclean: :after_each do
  let(:required_params) do
    { gender: 'Male', dob: Date.today.prev_year }
  end

  # ["White", "Black or African American", "Asian Indian", "Chinese" ],
  # ["Filipino", "Japanese", "Korean", "Vietnamese", "Other Asian"],
  # ["Native Hawaiian", "Samoan", "Guamanian or Chamorro", ],
  # ["Other Pacific Islander", "American Indian/Alaska Native", "Other"]
  let(:optional_params) do
    { ethnicity: ['ethnicity'],
      race: 'race',
      is_veteran_or_active_military: false,
      is_vets_spouse_or_child: false }
  end

  let(:input_params) do
    required_params.merge(optional_params)
  end

  context 'no params' do
    it 'should return failure' do
      expect(subject.call({})).to be_failure
    end

    it 'should return failure with error messages' do
      expect(subject.call({}).errors.to_h).to eq({ gender: ['is missing'], dob: ['is missing'] })
    end
  end

  context 'invalid params' do
    it 'should return failure with message' do
      expect(subject.call(input_params.merge(gender: 'gender')).errors.to_h).to eq({ gender: ['must be one of: Male, Female'] })
    end
  end

  context 'valid params' do
    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end
end