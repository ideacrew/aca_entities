# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/contracts/identifying_information_contract'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::IdentifyingInformationContract,  dbclean: :after_each do
  let(:required_params) do
    { has_ssn: false }
  end

  let(:optional_params) do
    { encrypted_ssn: '' }
  end

  let(:input_params) do
    required_params.merge(optional_params)
  end

  context 'no params' do
    it 'should return failure' do
      expect(subject.call({})).to be_failure
    end

    it 'should return failure with error messages' do
      expect(subject.call({}).errors.to_h).to eq({ has_ssn: ['is missing'] })
    end
  end

  context 'invalid params' do
    it 'should return failure with message' do
      expect(subject.call(input_params.merge(has_ssn: 1000)).errors.to_h).to eq({ has_ssn: ['must be boolean'] })
    end
  end

  context 'valid params' do
    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end
end
