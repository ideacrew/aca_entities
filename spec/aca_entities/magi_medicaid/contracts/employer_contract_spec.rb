# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/contracts/employer_contract'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::EmployerContract,  dbclean: :after_each do
  context 'valid params' do
    let(:all_params) { { employer_name: 'ABC employer', employer_id: '123456789' } }

    before do
      @result = subject.call(all_params)
    end

    it 'should return success' do
      expect(@result).to be_success
    end

    it 'should return all params' do
      expect(@result.to_h).to eq(all_params)
    end
  end

  context 'invalid params' do
    context 'no params' do
      before do
        @result = subject.call({})
      end

      it 'should return failure' do
        expect(@result).to be_failure
      end

      it 'should return a failure with error messages' do
        expect(@result.errors.to_h).to eq({ employer_name: ['is missing'], employer_id: ['is missing'] })
      end
    end

    context 'invalid data for employer id' do
      let(:all_params) do
        { employer_name: 'ABC employer', employer_id: ['abcdefghi', '12-3456789', '123#@!789'].sample }
      end

      before { @result = subject.call(all_params) }

      it 'should return failure' do
        expect(@result).to be_failure
      end

      it 'should return a failure with error message' do
        expect(@result.errors.to_h).to eq({ employer_id: ['should be of length 9 and allows numbers only'] })
      end
    end
  end
end
