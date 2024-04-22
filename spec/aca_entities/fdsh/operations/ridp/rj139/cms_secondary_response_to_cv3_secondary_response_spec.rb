# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Ridp::Rj139::Operations::CmsSecondaryResponseToCv3SecondaryResponse, dbclean: :after_each do

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
