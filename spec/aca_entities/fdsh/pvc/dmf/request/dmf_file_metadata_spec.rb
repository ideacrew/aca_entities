# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::Pvc::Dmf::Request::DMFFileMetadata do
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

  context 'valid attributes' do
    it 'should have the correct attributes' do
      expect { described_class.new(required_params) }.not_to raise_error
    end
  end

  context 'invalid attributes' do
    it 'should have the correct attributes' do
      required_params[:DMFDocumentAttachmentQuantity] = nil
      expect { described_class.new(required_params) }.to raise_error
    end
  end
end