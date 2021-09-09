# frozen_string_literal: true

require 'spec_helper'
RSpec.describe AcaEntities::Contracts::Contacts::PhoneContactContract,  dbclean: :after_each do
  let(:required_params) do
    { kind: 'home',
      area_code: '100',
      number: '1234567',
      primary: true }
  end
  let(:optional_params) do
    { country_code: '1', extension: '11', full_phone_number: '1001234567' }
  end

  context 'valid params' do
    context 'full_phone_number of 10 chars' do
      let(:input_params) do
        required_params.merge(optional_params).merge({ full_phone_number: '1234567890' })
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should return all params' do
        expect(@result.to_h).to eq(input_params)
      end
    end

    context 'full_phone_number of 10 chars' do
      let(:input_params) do
        required_params.merge(optional_params).merge({ full_phone_number: '123456789012345' })
      end

      before do
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should return all params' do
        expect(@result.to_h).to eq(input_params)
      end
    end
  end

  context 'invalid params' do

    context 'no params' do
      it 'should return failure with error message' do
        err_msg = { area_code: ['is missing'], kind: ['is missing'], number: ['is missing'], primary: ['is missing'] }
        expect(subject.call({}).errors.to_h).to eq(err_msg)
      end
    end

    context 'invalid value for kind' do
      let(:input_params) { required_params.merge({ kind: 'test' }) }

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(@result.errors.to_h).to eq({ kind: ['must be one of: home, work, mobile, main, fax, phone'] })
      end
    end

    context 'invalid value for area_code' do
      let(:input_params) { required_params.merge(optional_params).merge({ area_code: '1000' }) }

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(@result.errors.to_h).to eq({ area_code: ["length must be 3"] })
      end
    end

    context 'invalid value for number' do
      let(:input_params) { required_params.merge(optional_params).merge({ number: '1000' }) }

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(@result.errors.to_h).to eq({ number: ["length must be 7"] })
      end
    end

    context 'shorter value for full_phone_number' do
      let(:input_params) { required_params.merge(optional_params).merge({ full_phone_number: '1000' }) }

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(@result.errors.to_h).to eq({ full_phone_number: ['length must be within 10 - 15'] })
      end
    end

    context 'longer value for full_phone_number' do
      let(:input_params) { required_params.merge(optional_params).merge({ full_phone_number: '123456789123456789' }) }

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(@result.errors.to_h).to eq({ full_phone_number: ['length must be within 10 - 15'] })
      end
    end

    context 'alphabets as input for area_code' do
      let(:input_params) { required_params.merge(optional_params).merge({ area_code: 'abc' }) }

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(@result.errors.to_h).to eq({ area_code: ['is in invalid format'] })
      end
    end

    context 'alphabets as input for number' do
      let(:input_params) { required_params.merge(optional_params).merge({ number: 'abcdefg' }) }

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(@result.errors.to_h).to eq({ number: ['is in invalid format'] })
      end
    end

    context 'alphabets as input for full_phone_number' do
      let(:input_params) { required_params.merge(optional_params).merge({ full_phone_number: 'abcdefghij' }) }

      before do
        @result = subject.call(input_params)
      end

      it 'should return failure with error message' do
        expect(@result.errors.to_h).to eq({ full_phone_number: ['is in invalid format'] })
      end
    end
  end
end
