# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Pdm::Contracts::RequestContract, dbclean: :after_each do
  let(:valid_params) do
    {
      subject_id: "THIS_IS_THE_SUBJECT"
    }
  end
  let(:invalid_params) do
    {
    }
  end

  let(:optional_params) do
    {
      command: "medicare",
      request_payload: "{}",
      response_payload: "{}"
    }
  end

  describe 'with valid arguments' do

    it 'should return success' do
      expect(subject.call(valid_params)).to be_truthy
    end

    it 'should return success with optional params' do
      expect(subject.call(valid_params.merge(optional_params))).to be_truthy
    end

  end

  describe 'with invalid arguments' do

    it 'should be a failure with invalid params' do
      expect(subject.call(invalid_params).failure?).to be_truthy
    end

  end
end
