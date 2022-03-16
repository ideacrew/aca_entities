# frozen_string_literal: true

require 'spec_helper'
require 'bigdecimal'
require 'bigdecimal/util'

RSpec.describe AcaEntities::Ledger::Premium do
  subject { described_class }

  let(:id) { '12345' }
  let(:insured_age) { 33 }
  let(:amount) { 875.22.to_d }
  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { amount: amount } }
  let(:optional_params) { { id: id, insured_age: insured_age, timestamps: timestamps } }
  let(:all_params) { required_params.merge(optional_params) }

  describe 'With required arguments' do
    it 'should initialize' do
      expect(subject.new(required_params)).to be_a described_class
    end
  end

  describe 'Applying Comparable methods' do
    context 'and comparing two premiums with same attributes' do
      let(:premium_1) { all_params }
      let(:premium_2) { all_params }

      it 'they should be equal' do
        expect(described_class.new(premium_1)).to eq described_class.new(premium_2)
      end
    end

    context 'and comparing two premiums, one with different amount' do
      let(:premium_1) { all_params }
      let(:different_amount) { 606.32.to_d }
      let(:premium_2) { all_params.merge(amount: different_amount) }

      it 'they should not be equal' do
        expect(described_class.new(premium_1)).not_to eq described_class.new(premium_2)
      end
    end
  end
end
