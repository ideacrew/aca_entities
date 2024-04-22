# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::Vlp::Rx142::CloseCase::Operations::VerifyCloseCaseRequest, dbclean: :after_each do

  context 'with valid params' do
    let(:params) do
      {
        CaseNumber: 'jas15he4k1Du1HD'
      }
    end

    before do
      @result = subject.call(params)
    end

    it 'returns success' do
      expect(@result.success?).to be_truthy
      expect(@result.success.is_a?(AcaEntities::Fdsh::Vlp::Rx142::CloseCase::CloseCaseRequest)).to be_truthy
    end
  end

  context 'with invalid params' do
    let(:params) do
      {
        DateOfBirth: '12345'
      }
    end

    before do
      @result = subject.call(params)
    end

    it 'does not return success' do
      expect(@result.success?).to be_falsey
      expect(@result.is_a?(AcaEntities::Fdsh::Vlp::Rx142::CloseCase::CloseCaseRequest)).to be_falsey
    end
  end
end