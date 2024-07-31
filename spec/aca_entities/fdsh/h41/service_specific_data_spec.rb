# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::H41::ServiceSpecificData do
  subject { described_class.new }

  let(:params) do
    {
      ReportPeriod: {
        YearMonth: '2023-01'
      },
      OriginalBatchID: '123456'
    }
  end

  describe 'with valid arguments' do
    it 'should initialize' do
      expect(described_class.new(params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should not raise error' do
      expect do
        described_class.new(params.reject do |k, _v|
          k == :OriginalBatchID
        end)
      end.not_to raise_error(Dry::Struct::Error, /:DocumentFileName is missing/)
    end
  end
end
