# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::Pvc::Dmf::Contracts::ServiceSpecificDataContract, dbclean: :after_each do
  subject { described_class.new }

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
        required_params[:DMFFileMetadata][:DMFDocumentAttachmentQuantity] = "test"
        result = subject.call(required_params)
        expect(result.failure?).to be_truthy
      end
    end
  end
end