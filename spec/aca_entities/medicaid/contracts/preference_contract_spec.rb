# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/preference_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::PreferenceContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  context 'success case' do
    let(:input_params) do
      { contact_preference_Code: "TextMessage" }
    end

    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'invalid params' do
    let(:input_params) do
      { contact_preference_Code: true }
    end

    it 'should return failure with errors' do
      expect(subject.call(input_params).errors.to_h).to eq({ contact_preference_Code: ['must be a string'] })
    end
  end
end
