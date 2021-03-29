# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/person_name_contract'

RSpec.describe ::AcaEntities::Contracts::PersonNameContract,  dbclean: :after_each do

  # required(:first_name).filled(:string)
  # optional(:middle_name).maybe(:string)
  # required(:last_name).filled(:string)
  # optional(:name_sfx).maybe(:string)
  # optional(:name_pfx).maybe(:string)
  # optional(:start_on).maybe(:date)
  # optional(:end_on).maybe(:date)

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
  end

end
