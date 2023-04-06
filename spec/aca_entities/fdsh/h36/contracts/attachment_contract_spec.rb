# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::H36::Contracts::AttachmentContract, dbclean: :after_each do
  subject { described_class.new }

  let(:required_params) do
    {
      DocumentBinary: {
        ChecksumAugmentation: {
          SHA256HashValueText: '123'
        },
        BinarySizeValue: 1
      },
      DocumentFileName: '123',
      DocumentSequenceID: '123'
    }
  end

  let(:error_messages) do
    {
      DocumentBinary: ['is missing'],
      DocumentFileName: ['is missing'],
      DocumentSequenceID: ['is missing']
    }
  end

  context 'success case' do
    context 'with params passed' do
      it 'should return success' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
      end
    end
  end

  context "failure case" do
    context "with missing params" do
      it "should return failure" do
        result = subject.call({})
        expect(result.failure?).to be_truthy
      end

      it 'should return error messages' do
        result = subject.call({})
        expect(result.errors.to_h).to eq error_messages
      end
    end
  end
end