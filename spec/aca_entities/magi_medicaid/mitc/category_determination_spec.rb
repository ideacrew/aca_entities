# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::CategoryDetermination do
  let(:category_determination) do
    { category: 'Child Category',
      indicator_code: 'N',
      ineligibility_code: 115,
      ineligibility_reason: 'Applicant is 19 years of age or older and the state does not cover young adults under age 20 or 21' }
  end

  describe 'with valid arguments' do
    before do
      contract_params = ::AcaEntities::MagiMedicaid::Mitc::Contracts::CategoryDeterminationContract.new.call(category_determination).to_h
      @result = described_class.new(contract_params)
    end

    it 'should return CategoryDetermination entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of CategoryDetermination' do
      expect(@result.to_h.keys).to eq(category_determination.keys)
    end
  end
end
