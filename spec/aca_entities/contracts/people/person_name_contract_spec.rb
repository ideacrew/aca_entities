# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::People::PersonNameContract,  dbclean: :after_each do

  let(:required_params) do
    { first_name: 'first', last_name: 'last' }
  end

  let(:optional_params) do
    { middle_name: 'middle',
      name_sfx: 'suffix',
      name_pfx: 'prefix',
      start_on: Date.today.prev_year.to_s,
      end_on: '' }
  end

  let(:input_params) do
    required_params.merge(optional_params)
  end

  context 'no params' do
    it 'should return failure' do
      expect(subject.call({})).to be_failure
    end

    it 'should return failure with error messages' do
      expect(subject.call({}).errors.to_h).to eq({ first_name: ['is missing'], last_name: ['is missing'] })
    end
  end

  context 'invalid params' do
    it 'should return failure with message' do
      expect(subject.call(input_params.merge(first_name: 1000)).errors.to_h).to eq({ first_name: ['must be a string'] })
    end
  end

  context 'valid params' do
    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end

    context 'with required params only' do
      it 'should return success' do
        expect(subject.call(required_params)).to be_success
      end
    end
  end
end
