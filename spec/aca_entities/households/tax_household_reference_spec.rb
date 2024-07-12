# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Households::TaxHouseholdReference do

  let(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
    }
  end

  let(:input_params) do
    {
      hbx_id: '123456789',
      max_aptc: currency,
      yearly_expected_contribution: currency
    }
  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(input_params.reject do |k, _v|
                              k == :max_aptc
                            end)
      end.to raise_error(Dry::Struct::Error, /:max_aptc is missing/)
    end
  end
end
