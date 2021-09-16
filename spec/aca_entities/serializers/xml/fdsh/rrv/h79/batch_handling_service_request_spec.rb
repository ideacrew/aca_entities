# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ssa'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Rrv::H79::BatchHandlingServiceRequest,
               "given a minimal medicare batch request" do

  let(:rrv_medicare_manifest_request) do
    AcaEntities::Fdsh::Rrv::H79::BatchHandlingServiceRequest.new(
      {
        BatchMetadata: batch_metadata,
        TransmissionMetadata: transmission_metadata,
        ServiceSpecificData: service_specific_data
      }
    )
  end

  let(:batch_metadata) do
    {
      BatchID: "1000-01-01T00:00:00Z",
      BatchPartnerID: "00.AA*.000.000.000",
      BatchAttachmentTotalQuantity: 20,
      BatchCategoryCode: "RRV_REQ",
      BatchTransmissionQuantity: 20
    }
  end

  let(:transmission_metadata) do
    {
      TransmissionAttachmentQuantity: 2000,
      TransmissionSequenceID: 1
    }
  end

  let(:service_specific_data) do
    {
      IRSFileMetadata: irs_file_metadata,
      SSAFileMetadata: ssa_file_metadata,
      MedicareFileMetadata: medicare_file_metadata,
      CurrentIncomeFileMetadata: current_income_file_metadata
    }
  end

  let(:irs_file_metadata) do
    {
      IRSDocumentAttachmentQuantity: 50,
      Attachments: [attachment]
    }
  end

  let(:ssa_file_metadata) do
    {
      SSADocumentAttachmentQuantity: 1,
      Attachment: attachment
    }
  end

  let(:medicare_file_metadata) do
    {
      MedicareDocumentAttachmentQuantity: 1,
      Attachment: attachment
    }
  end

  let(:current_income_file_metadata) do
    {
      CurrentIncomeDocumentAttachmentQuantity: 1,
      Attachment: attachment
    }
  end

  let(:attachment) do
    {
      DocumentBinary: {
        ChecksumAugmentation: {
          SHA256HashValueText: "0000000000000000000000000000000000000000000000000000000000000000"
        },
        BinarySizeValue: 20.00
      },
      DocumentFileName: "IFSV_Request_00001_10000101T000000000Z.xml",
      DocumentSequenceID: "00001",
      DocumentRecordCount: 20
    }
  end

  subject do
    AcaEntities::Serializers::Xml::Fdsh::Rrv::H79::BatchHandlingServiceRequest.domain_to_mapper(
      rrv_medicare_manifest_request
    ).to_xml
  end

  it "creates a schema valid result" do

    validation_result = AcaEntities::Serializers::Xml::Fdsh::Rrv::H79::Operations::ValidateRrvManifestRequestPayloadXml.new.call(subject)
    expect(validation_result.success?).to be_truthy
  end
end
