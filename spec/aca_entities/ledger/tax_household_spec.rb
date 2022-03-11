# frozen_string_literal: true

require 'spec_helper'
require 'bigdecimal'
require 'bigdecimal/util'

RSpec.describe AcaEntities::Ledger::TaxHousehold do
  subject { described_class }

  let(:id) { '12345' }
  let(:exchange_assigned_id) { '787878' }
  let(:assistance_year) { moment.year }
  let(:aptc_amount) { 585.69.to_d }
  let(:start_on) { Date.new(moment.year, moment.month, 1) }
  let(:end_on) { (start_on + 1.month).prev_day }
  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      assistance_year: assistance_year,
      exchange_assigned_id: exchange_assigned_id,
      aptc_amount: aptc_amount,
      start_on: start_on
    }
  end
  let(:optional_params) { { id: id, end_on: end_on, timestamps: timestamps } }
  let(:all_params) { required_params.merge(optional_params) }

  describe 'with required arguments' do
    it 'should initialize' do
      expect(subject.new(required_params)).to be_a described_class
    end
  end

  describe 'Applying Comparable methods' do
    context 'and comparing two tax_households with same attributes' do
      let(:product_1) { all_params }
      let(:product_2) { all_params }

      it 'they should be equal' do
        expect(subject.new(product_1)).to eq subject.new(product_2)
      end
    end

    context 'and comparing two tax_households, one with different aptc_amount' do
      let(:product_1) { all_params }
      let(:product_2) { all_params.merge(aptc_amount: 400.1.to_d) }

      it 'they should not be equal' do
        expect(subject.new(product_1)).not_to eq subject.new(product_2)
      end
    end

    context 'and comparing two tax_households, one with different assistance_year' do
      let(:product_1) { all_params }
      let(:product_2) { all_params.merge(assistance_year: 2023) }

      it 'they should not be equal' do
        expect(subject.new(product_1)).not_to eq subject.new(product_2)
      end
    end
  end
end
