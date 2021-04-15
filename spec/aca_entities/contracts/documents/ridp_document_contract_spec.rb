# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Documents::RidpDocumentContract, dbclean: :after_each do

  let(:required_params) do
    {
      title: "license - back.pdf",
      creator: "mhc",
      subject: "license - back.pdf",
      description: nil,
      publisher: "mhc",
      contributor: nil,
      date: Date.today,
      type: "text",
      format: "application/octet-stream",
      identifier: nil, source: "enroll_system",
      language: "en", relation: nil, coverage: nil,
      rights: 'public',
      tags: [],
      size: nil,
      doc_identifier: nil,
      status: "downloaded",
      ridp_verification_type: "Identity",
      comment: nil,
      uploaded_at: Date.today
    }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :status })
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(uploaded_at: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be a date')
      end
    end
  end
end
