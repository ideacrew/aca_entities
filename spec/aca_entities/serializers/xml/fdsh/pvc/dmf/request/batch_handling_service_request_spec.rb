# frozen_string_literal: true

# lib/aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_name.rb

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/pvc'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Request::BatchHandlingServiceRequest do
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
  let(:entity) { AcaEntities::Fdsh::Pvc::Dmf::Request::BatchHandlingServiceRequest.new(required_params)}

  it 'returns a serialized object' do
    result = described_class.domain_to_mapper(entity)
    expect(result).to be_a(AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Request::BatchHandlingServiceRequest)
  end

  it 'should convert to xml' do
    result = described_class.domain_to_mapper(entity)
    expect(result.to_xml.split("\n").first).to eq '<?xml version="1.0"?>'
    expect(result.to_xml.split("\n")[1]).to match(/<exch:BatchHandlingServiceRequest xmlns:exch=/)
    expect(result.to_xml.split("\n")[8]).to match(/hix-core:BatchMetadata/)
    expect(result.to_xml.split("\n")[9]).to match(/hix-core:TransmissionMetadata/)
    expect(result.to_xml.split("\n")[13]).to match(/ext:ServiceSpecificData/)
  end
end