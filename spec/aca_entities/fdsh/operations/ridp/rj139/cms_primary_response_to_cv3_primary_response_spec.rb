# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Ridp::Rj139::Operations::CmsPrimaryResponseToCv3PrimaryResponse do

  describe 'cms response' do
    let(:input_params) do
      {
        ridpResponse: {
          responseMetadata: {
            responseCode: "ABCDEFGH",
            responseText: "ABCDEFGHIJKLMNOPQRSTUVWXYZA",
            tdsResponseText: "ABCDEFGHIJKLMNOPQRSTU"
          },
          sessionIdentification: "# Ik5/ 77RnhJ",
          verificationQuestionArray: [
            {
              verificationQuestionSet: {
                verificationQuestionText: "ABCDEFG",
                verificationAnswerChoiceArray: [
                  {
                    verificationAnswerChoiceText: "ABCDEFGHIJKLMNOPQRSTUVWXYZABC"
                  }
                ]
              }
            },
            {
              verificationQuestionSet: {
                verificationQuestionText: "ABCDEFGHIJKLMN",
                verificationAnswerChoiceArray: [
                  {
                    verificationAnswerChoiceText: "ABCDEFGHIJKLMNOPQ"
                  }
                ]
              }
            },
            {
              verificationQuestionSet: {
                verificationQuestionText: "ABCD",
                verificationAnswerChoiceArray: [
                  {
                    verificationAnswerChoiceText: "ABCDEFGHIJKLM"
                  }
                ]
              }
            },
            {
              verificationQuestionSet: {
                verificationQuestionText: "ABCDEFGHIJKLMNOP",
                verificationAnswerChoiceArray: [
                  {
                    verificationAnswerChoiceText: "ABCDEFGHIJKLMNOPQRSTUVWXYZAB"
                  }
                ]
              }
            },
            {
              verificationQuestionSet: {
                verificationQuestionText: "ABCDEFGHIJKLMNOPQRSTUVWXYZA",
                verificationAnswerChoiceArray: [
                  {
                    verificationAnswerChoiceText: "ABCDEFG"
                  }
                ]
              }
            }
          ],
          finalDecisionCode: "ACC",
          hubReferenceNumber: "ABCDEFGH"
        }
      }
    end

    context 'with valid response' do
      before do
        @result = subject.call(input_params)
      end

      it 'should return success' do
        expect(@result).to be_success
      end
    end

    context 'with invalid response' do

      before do
        input_params[:ridpResponse].delete(:responseMetadata)
        @result = subject.call(input_params)
      end

      it 'should return failure' do
        expect(@result).to be_failure
      end

    end
  end
end
