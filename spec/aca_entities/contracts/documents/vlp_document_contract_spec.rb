# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Contracts::Documents::VlpDocumentContract, dbclean: :after_each do

  let(:input_params) do
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
      expiration_date: DateTime.now,
      issuing_country: "USA",
      description: 'it is a test description'
    }
  end

  context 'for expiration_date as string' do
    let(:valid_params) { input_params.merge({ expiration_date: '2021-07-31' }) }

    before do
      @result = subject.call(valid_params)
    end

    it 'should return success with coercing expiration_date' do
      expect(@result).to be_success
      expect(@result.to_h[:expiration_date]).to be_a(DateTime)
    end
  end

  context "with invalid params" do
    it "should fail validation" do
      result = subject.call(input_params.reject { |k, _v| k == :subject })
      expect(result.success?).to be_falsey
      expect(result.errors.to_h).to eq({ :subject => ["is missing"] })
    end
  end

  context "and all required and optional parameters" do
    it "should pass validation" do
      result = subject.call(input_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq input_params
    end
  end

  context 'success case' do
    before do
      @result = subject.call(input_params)
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
        @result = subject.call(input_params.reject { |k, _v| k == :subject })
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
        @result = subject.call(input_params.merge(alien_number: '123'))
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
        result = subject.call(input_params.merge(expiration_date: 'date string'))
        expect(result.errors.messages.first.text).to eq('must be a date time')
      end
    end
  end
end
