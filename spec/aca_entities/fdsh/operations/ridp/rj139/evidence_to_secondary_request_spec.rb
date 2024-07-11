# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Ridp::Rj139::Operations::EvidenceToSecondaryRequest do

  describe 'with valid arguments' do
    context 'with valid payload' do
      let!(:payload) do
        {
          :SessionIdentification => "347567asghfjgshfg",
          :VerificationAnswerSet =>
            { :VerificationAnswers =>
              [
                { :VerificationQuestionNumber => 1, :VerificatonAnswer => 1 },
                { :VerificationQuestionNumber => 2, :VerificatonAnswer => 1 },
                { :VerificationQuestionNumber => 3, :VerificatonAnswer => 2 }
              ] },
          :DSHReferenceNumber => "test"
        }
      end

      before do
        @result = subject.call(payload)
        @json_result = JSON.parse(@result.success)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

    end

    context 'with invalid payload' do
      let!(:payload) do
        {
          :SessionIdentification => "347567asghfjgshfg",
          :VerificationAnswerSet =>
            { :VerificationAnswers =>
              [
                { :VerificationQuestionNumber => 1, :VerificatonAnswer => 1 },
                { :VerificationQuestionNumber => 2, :VerificatonAnswer => 1 },
                { :VerificationQuestionNumber => 3, :VerificatonAnswer => 2 }
              ] }
        }
      end

      before do
        @result = subject.call(payload)
      end

      it 'should return failure' do
        expect(@result).to be_failure
      end

    end
  end
end
