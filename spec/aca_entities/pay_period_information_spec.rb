# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/pay_period_information'

RSpec.describe ::AcaEntities::PayPeriodInformation do

  describe 'with valid arguments' do
    let(:input_params) do
      { end_date: Date.today.next_year,
        hours_worked_in_pay_period: 20,
        data_source_income_type_amount: 100.00 }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
