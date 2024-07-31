# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Cms::Pbp::ProratedAmount do
  subject { described_class.new }

  let(:required_params) do
    {
      partial_month_premium: BigDecimal('100.00'),
      partial_month_start_date: Date.today,
      partial_month_end_date: Date.today
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
          k == :partial_month_start_date
        end)
      end.to raise_error(Dry::Struct::Error, /:partial_month_start_date is missing/)
    end
  end
end
