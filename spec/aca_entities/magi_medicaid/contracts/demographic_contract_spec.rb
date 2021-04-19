# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::DemographicContract,  dbclean: :after_each do
  context 'applicant not applying for coverage' do
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

  context 'applicant applying for coverage' do
    let(:required_params) do
      { gender: 'Male', dob: Date.today.prev_year }
    end

    let(:input_params) do
      required_params.merge(optional_params)
    end

    context 'valid params' do
      let(:optional_params) do
        { ethnicity: ['ethnicity'],
          race: 'race',
          is_veteran_or_active_military: false,
          is_vets_spouse_or_child: false }
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should return failure with error message' do
        expect(@result.to_h).to eq(input_params)
      end
    end
  end
end