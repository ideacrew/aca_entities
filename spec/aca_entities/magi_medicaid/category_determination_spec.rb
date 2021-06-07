# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::CategoryDetermination do

  before do
    contract_params = ::AcaEntities::MagiMedicaid::Contracts::CategoryDeterminationContract.new.call(category_determination).to_h
    @result = described_class.new(contract_params)
  end

  context 'indicator_code is set to false' do
    let(:category_determination) do
      { category: 'Child Category',
        indicator_code: false,
        ineligibility_code: 115,
        ineligibility_reason: 'Applicant is 19 years of age or older and the state does not cover young adults under age 20 or 21' }
    end

    it 'should return CategoryDetermination entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of CategoryDetermination' do
      expect(@result.to_h.keys).to eq(category_determination.keys)
    end
  end

  context 'indicator_code is set to true' do
    let(:category_determination) do
      { category: 'Child Category',
        indicator_code: true,
        ineligibility_code: nil,
        ineligibility_reason: nil }
    end

    it 'should return CategoryDetermination entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of CategoryDetermination' do
      expect(@result.to_h.keys).to eq(category_determination.keys)
    end
  end

  context 'indicator_code is set to nil' do
    let(:category_determination) do
      { category: 'Child Category',
        indicator_code: nil,
        ineligibility_code: nil,
        ineligibility_reason: nil }
    end

    it 'should return CategoryDetermination entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of CategoryDetermination' do
      expect(@result.to_h.keys).to eq(category_determination.keys)
    end
  end
end
