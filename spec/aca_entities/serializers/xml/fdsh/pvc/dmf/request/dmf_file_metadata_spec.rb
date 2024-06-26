# frozen_string_literal: true

# lib/aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_name.rb

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/pvc'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Request::DMFFileMetadata do
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
  let(:entity) { AcaEntities::Fdsh::Pvc::Dmf::Request::DMFFileMetadata.new(required_params)}

  it 'returns a serialized object' do
    result = described_class.domain_to_mapper(entity)
    expect(result).to be_a(AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Request::DMFFileMetadata)
  end

  it 'should convert to xml' do
    result = described_class.domain_to_mapper(entity)
    expect(result.to_xml.split("\n").first).to eq '<?xml version="1.0"?>'
    expect(result.to_xml.split("\n")[1]).to match(/ext:DMFFileMetadata/)
    expect(result.to_xml.split("\n")[2]).to match(/ext:DMFDocumentAttachmentQuantity/)
  end
end