# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::H36::BatchHandlingServiceRequest do
  subject { described_class.new }

  let(:batch_metadata) do
    {
      BatchID: '123',
      BatchPartnerID: '123',
      BatchAttachmentTotalQuantity: 1,
      BatchCategoryCode: '123',
      BatchTransmissionQuantity: 1
    }
  end

  let(:transmission_metadata) do
    {
      TransmissionSequenceID: 123,
      TransmissionAttachmentQuantity: 1
    }
  end

  let(:service_specific_data) do
    {
      ReportPeriod: {
        YearMonth: '2023-01'
      }
    }
  end

  let(:attachments) do
    [
      {
        DocumentBinary: {
          ChecksumAugmentation: {
            SHA256HashValueText: '123'
          },
          BinarySizeValue: 1
        },
        DocumentFileName: '123',
        DocumentSequenceID: '123'
      }
    ]
  end

  let(:required_params) do
    {
      BatchMetadata: batch_metadata,
      TransmissionMetadata: transmission_metadata,
      ServiceSpecificData: service_specific_data,
      Attachments: attachments
    }
  end

  describe 'with valid arguments' do
    it 'should initialize' do
      expect(described_class.new(required_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(required_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(required_params.reject do |k, _v|
          k == :BatchMetadata
        end)
      end.to raise_error(Dry::Struct::Error, /:BatchMetadata is missing/)
    end
  end
end
