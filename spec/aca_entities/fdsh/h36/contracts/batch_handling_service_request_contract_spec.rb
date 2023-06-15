# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/fdsh/h36/irs_household_coverage_shared_context'

RSpec.describe AcaEntities::Fdsh::H36::Contracts::BatchHandlingServiceRequestContract, dbclean: :after_each do
  subject { described_class.new }

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

  let(:error_messages) do
    {
      BatchMetadata: ['is missing'],
      TransmissionMetadata: ['is missing'],
      ServiceSpecificData: ['is missing'],
      Attachments: ['is missing']
    }
  end

  context 'failure case' do
    context 'missing_required params' do
      it 'should return failure' do
        result = subject.call({})
        expect(result.failure?).to be_truthy
      end

      it 'should return error messages' do
        result = subject.call({})
        expect(result.errors.to_h).to eq error_messages
      end
    end
  end

  context 'success case' do
    context 'required params' do
      it 'should return success' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
      end
    end
  end
end