# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::H36::Attachment, dbclean: :after_each do
  subject { described_class.new }

  let(:required_params) do
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
          k == :DocumentFileName
        end)
      end.to raise_error(Dry::Struct::Error, /:DocumentFileName is missing/)
    end
  end
end