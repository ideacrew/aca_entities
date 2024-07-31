# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Cms::Pbp::FinancialInformation do
  subject { described_class.new }

  let(:required_params) do
    {
      financial_effective_start_date: Date.today,
      financial_effective_end_date: Date.today,
      monthly_premium_amount: BigDecimal('100.00'),
      monthly_responsible_amount: BigDecimal('100.00')
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
          k == :monthly_premium_amount
        end)
      end.to raise_error(Dry::Struct::Error, /:monthly_premium_amount is missing/)
    end
  end
end
