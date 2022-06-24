# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::PremiumCredits::Contracts::ObjectReferenceContract,  dbclean: :after_each do
  describe 'initialize' do
    let(:params) do
      { identifier: '100',
        label: 'FinancialAssistance::Application' }
    end

    context 'valid params' do
      before do
        @result = subject.call(params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should return all params' do
        expect(@result.to_h).to eq(params)
      end
    end

    context 'invalid params' do
      before do
        @result = subject.call(
          { identifier: 100, label: 199 }
        )
      end

      it 'should return failure' do
        expect(@result).to be_failure
      end

      it 'should return a failure with error messages' do
        expect(@result.errors.to_h).to eq(
          { identifier: ['must be a string'], label: ['must be a string'] }
        )
      end
    end
  end
end
