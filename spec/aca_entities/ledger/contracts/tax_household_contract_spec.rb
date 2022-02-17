# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::TaxHouseholdContract do
  subject { described_class.new }

  let(:id) { '12345' }
  let(:aptc_amount_total) { 585.69 }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { {} }
  let(:optional_params) { { id: id, aptc_amount_total: aptc_amount_total, timestamps: timestamps } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
    context 'Calling the contract with required params' do
      it 'should pass validation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Calling the contract with all params' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) { { effective_year: ['is missing'], hios_id: ['is missing'], kind: ['is missing'] } }
    it 'should pass validation' do
      result = subject.call({})
      expect(result.success?).to be_truthy
      expect(result.errors.to_h).to be_empty
    end
  end
end
