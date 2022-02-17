# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Contracts::PremiumContract do
  subject { described_class.new }

  let(:id) { '12345' }

  let(:hios_id) { '96667ME031005806' }
  let(:effective_year) { 2022 }
  let(:kind) { 'health' }
  let(:product) { { hios_id: hios_id, effective_year: effective_year, kind: kind } }

  let(:rating_area_id) { 'R-ME001' }
  let(:member_age_on_effective_date) { 33 }
  let(:amount) { 875.22 }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      product: product,
      rating_area_id: rating_area_id,
      amount: amount,
      member_age_on_effective_date: member_age_on_effective_date
    }
  end

  let(:optional_params) { { id: id, timestamps: timestamps } }

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
    context 'Calling the contract with required params' do
      it 'should pass vaidation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Calling the contract with all params' do
      it 'should pass vaidation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        amount: ['is missing'],
        member_age_on_effective_date: ['is missing'],
        product: ['is missing'],
        rating_area_id: ['is missing']
      }
    end

    it 'should fail vaidation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
