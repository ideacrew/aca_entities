# frozen_string_literal: true

# lib/aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_name.rb

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/pvc'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Operations::DmfManifestRequestToXml do
  let(:manifest_hash) do
    {
      :BatchMetadata => { :BatchID => "2024-06-10T18:38:16Z", :BatchPartnerID => "02.ME*.SBE.001.001", :BatchAttachmentTotalQuantity => 1,
                          :BatchCategoryCode => "PVC_REQ", :BatchTransmissionQuantity => 1 },
      :TransmissionMetadata => { :TransmissionAttachmentQuantity => 1, :TransmissionSequenceID => 1 },
      :ServiceSpecificData => { :DMFFileMetadata => { :DMFDocumentAttachmentQuantity => 1,
                                                      :Attachment => { :DocumentBinary => { :ChecksumAugmentation =>
                          { :SHA256HashValueText => "010d57fb60421c1e7474d9408250f7afa0283efb429d34a89686d873ce1d2ac6" },
                                                                                            :BinarySizeValue => 663 },
                                                                       :DocumentFileName => "DMAF_Request_00001_20240610T183815461Z.xml",
                                                                       :DocumentSequenceID => "00001", :DocumentRecordCount => 1 } } }
    }
  end
  let(:manifest_entity) { AcaEntities::Fdsh::Pvc::Dmf::Request::BatchHandlingServiceRequest.new(manifest_hash)}

  before do
    @result = described_class.new.call(manifest_entity)
  end

  it 'returns a serialized object' do
    expect(@result.success?).to be_truthy
  end

  it 'should convert to xml' do
    expect(@result.success).to match(/<exch:BatchHandlingServiceRequest/)
    expect(@result.success).to match(/<hix-core:BatchMetadata/)
    expect(@result.success).to include("<ext:BatchCategoryCode>PVC_REQ</ext:BatchCategoryCode>")
    expect(@result.success).to include("<hix-core:BatchTransmissionQuantity>1</hix-core:BatchTransmissionQuantity>")
  end
end