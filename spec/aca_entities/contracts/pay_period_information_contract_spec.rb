# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/pay_period_information_contract'

RSpec.describe ::AcaEntities::Contracts::PayPeriodInformationContract, dbclean: :after_each do

  let(:input_params) do
    { end_date: Date.today.next_year,
      hours_worked_in_pay_period: 20,
      data_source_income_type_amount: 100.00 }
  end

  context 'with all parameters' do
    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should return all the params' do
      expect(@result.to_h).to eq input_params
    end
  end
end
