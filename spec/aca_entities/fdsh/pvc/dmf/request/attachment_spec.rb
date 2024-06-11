# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::Pvc::Dmf::Request::Attachment do
  let(:required_params) do
    { DocumentBinary: { ChecksumAugmentation: { SHA256HashValueText: "test" },
                        BinarySizeValue: 1 },
      DocumentFileName: "test.pdf",
      DocumentSequenceID: "test",
      DocumentRecordCount: 1 }
  end

  context 'valid attributes' do
    it 'should have the correct attributes' do
      expect { described_class.new(required_params) }.not_to raise_error
    end
  end

  context 'invalid attributes' do
    it 'should have the correct attributes' do
      required_params[:DocumentFileName] = nil
      expect { described_class.new(required_params) }.to raise_error
    end
  end
end