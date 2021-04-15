# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Contracts::Documents::VlpDocumentContract, dbclean: :after_each do

  let(:required_params) do
    {
      title: "untitled",
      creator: "dchl",
      subject: "Naturalization Certificate",
      publisher: "dchl",
      contributor: nil,
      date: Date.today,
      type: "text",
      format: "application/octet-stream",
      identifier: nil,
      source: "enroll_system",
      language: "en",
      relation: nil,
      coverage: nil,
      rights: 'public',
      tags: [], size: nil,
      doc_identifier: nil,
      alien_number: "011020000",
      i94_number: nil,
      visa_number: nil,
      passport_number: nil,
      sevis_id: nil,
      naturalization_number: nil,
      receipt_number: nil,
      citizenship_number: nil,
      card_number: nil,
      country_of_citizenship: nil,
      expiration_date: Date.new(2022, 3, 8),
      issuing_country: "USA",
      description: 'it is a test description',
      status: "not submitted",
      verification_type: "Citizenship",
      comment: nil
    }
  end

  context "with invalid params" do
    it "should fail validation" do
      result = subject.call(required_params.reject { |k, _v| k == :title })
      expect(result.success?).to be_falsey
      expect(result.errors.to_h).to eq({ :title => ["is missing"] })
    end
  end

  context "and all required and optional parameters" do
    it "should pass validation" do
      result = subject.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
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
        @result = subject.call(required_params.reject { |k, _v| k == :title })
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
        @result = subject.call(required_params.merge(alien_number: '123'))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('length must be 9')
      end

      it 'should return error message' do
        result = subject.call(required_params.merge(expiration_date: nil))
        expect(result.errors.messages.first.text).to eq('must be a date')
      end
    end
  end
end
