# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::Pvc::Dmf::Request::BatchHandlingServiceRequest do
  let(:batch_metadata_contract) do
    {
      BatchID: "12345",
      BatchPartnerID: "12345",
      BatchAttachmentTotalQuantity: 2,
      BatchCategoryCode: "EOM",
      BatchTransmissionQuantity: 1
    }
  end

  let(:transmission_meta_data) do
    {
      TransmissionAttachmentQuantity: 1,
      TransmissionSequenceID: 12_345
    }
  end

  let(:service_specific_data) do
    {
      ReportPeriod: { YearMonth: "#{Date.today.year} - #{Date.today.month}" }
    }
  end

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
      BatchMetadata: batch_metadata_contract,
      TransmissionMetadata: transmission_meta_data,
      ServiceSpecificData: service_specific_data,
      Attachments: [attachment]
    }
  end

  context 'valid attributes' do
    it 'should have the correct attributes' do
      expect { described_class.new(required_params) }.not_to raise_error
    end
  end

  context 'invalid attributes' do
    it 'should have the correct attributes' do
      required_params[:BatchMetadata] = nil
      expect { described_class.new(required_params) }.to raise_error
    end
  end
end