# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::Pvc::Dmf::Contracts::DMFFileMetadataContract, dbclean: :after_each do
  subject { described_class.new }

  let(:attachment) do
    {
      DocumentBinary: { ChecksumAugmentation: { SHA256HashValueText: "ksahdjkashdkjash" }, BinarySizeValue: 2345 },
      DocumentFileName: "test",
      DocumentSequenceID: "12345",
      DocumentRecordCount: 1
    }
  end

  let(:required_params) do
    {
      DMFDocumentAttachmentQuantity: 1,
      Attachment: attachment
    }
  end

  let(:error_messages) do
    {
      DMFDocumentAttachmentQuantity: ['is missing'],
      Attachment: ['is missing']
    }
  end

  context 'failure case' do
    context 'missing_required params' do
      it 'should return failure' do
        result = subject.call({})
        expect(result.failure?).to be_truthy
      end

      it 'should return error messages' do
        result = subject.call({})
        expect(result.errors.to_h).to eq error_messages
      end
    end
  end

  context 'success case' do
    context 'required params' do
      it 'should return success' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
      end
    end
  end
end