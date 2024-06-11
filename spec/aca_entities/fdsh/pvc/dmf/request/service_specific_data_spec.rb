# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::Pvc::Dmf::Request::ServiceSpecificData do
  let(:attachment) do
    {
      DocumentBinary: { ChecksumAugmentation: { SHA256HashValueText: "ksahdjkashdkjash" }, BinarySizeValue: 2345 },
      DocumentFileName: "test",
      DocumentSequenceID: "12345",
      DocumentRecordCount: 1
    }
  end

  let(:dmf_meta_contract) do
    {
      DMFDocumentAttachmentQuantity: 1,
      Attachment: attachment
    }
  end

  let(:response_meta_contract) do
    { ResponseCode: "8493",
      ResponseDescriptionText: "test",
      TDSResponseDescriptionText: "test" }
  end

  let(:required_params) do
    { DMFFileMetadata: dmf_meta_contract,
      ResponseMetadata: response_meta_contract,
      EFTFileName: "test" }
  end

  context 'valid attributes' do
    it 'should have the correct attributes' do
      expect { described_class.new(required_params) }.not_to raise_error
    end
  end

  context 'invalid attributes' do
    it 'should have the correct attributes' do
      required_params[:DMFFileMetadata][:DMFDocumentAttachmentQuantity] = "test"
      expect { described_class.new(required_params) }.to raise_error
    end
  end
end