# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::H36::BatchHandlingServiceRequest do
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
      DocumentSequenceID: "12345"
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

  let(:batch_handling_service_request) do
    AcaEntities::Fdsh::H36::BatchHandlingServiceRequest.new(required_params)
  end

  describe '.domain_to_mapper' do

    it 'maps domain objects to mapper' do
      result = described_class.domain_to_mapper(batch_handling_service_request)

      expect(result).to be_a(AcaEntities::Serializers::Xml::Fdsh::H36::BatchHandlingServiceRequest)
    end
  end
end
