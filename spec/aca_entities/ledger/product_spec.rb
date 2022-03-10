# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Product do
  subject { described_class }

  let(:id) { '12345' }
  let(:hbx_qhp_id) { '96667ME031005806' }
  let(:effective_year) { 2022 }
  let(:kind) { 'health' }
  let(:name) { 'Comprehensive Coverage Level 11' }
  let(:expense_account_name) { '2022 Harvard Pilgrim Member Full Premiums' }
  let(:income_account) { { number: 410_010, name: name, kind: 'revenue', parent: 'account_4100' } }
  let(:expense_account) { { number: 810_010, name: expense_account_name, kind: 'expense', parent: 'account_8100' } }

  let(:description) { 'Includes all health care from head to toe' }
  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { hbx_qhp_id: hbx_qhp_id, effective_year: effective_year, kind: kind } }
  let(:optional_params) do
    {
      id: id,
      name: name,
      income_account: income_account,
      expense_account: expense_account,
      description: description,
      timestamps: timestamps
    }
  end
  let(:all_params) { required_params.merge(optional_params) }

  describe 'with required arguments' do
    it 'should initialize' do
      expect(subject.new(required_params)).to be_a described_class
    end
  end

  describe 'Applying Comparable methods' do
    context 'and comparing two products with same attributes' do
      let(:product_1) { all_params }
      let(:product_2) { all_params }

      it 'they should be equal' do
        expect(described_class.new(product_1)).to eq described_class.new(product_2)
      end
    end

    context 'and comparing two products, one with different effective_year' do
      let(:product_1) { all_params }
      let(:product_2) { all_params.merge(effective_year: 2023) }

      it 'they should not be equal' do
        expect(described_class.new(product_1)).not_to eq described_class.new(product_2)
      end
    end
  end
end
