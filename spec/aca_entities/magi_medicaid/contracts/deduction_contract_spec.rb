# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::DeductionContract,  dbclean: :after_each do
  let(:required_params) do
    { kind: 'tuition_and_fees',
      amount: 1000.67,
      start_on: Date.today.prev_year.to_s,
      frequency_kind: 'Monthly' }
  end

  let(:optional_params) do
    { name: 'name',
      end_on: nil,
      submitted_at: DateTime.now.to_s }
  end

  let(:input_params) do
    required_params.merge(optional_params)
  end

  context 'no params' do
    it 'should return failure' do
      expect(subject.call({})).to be_failure
    end

    it 'should return failure with error messages' do
      err_hash = { amount: ['is missing'], frequency_kind: ['is missing'], kind: ['is missing'], start_on: ['is missing'] }
      expect(subject.call({}).errors.to_h).to eq(err_hash)
    end
  end

  context 'invalid params' do
    it 'should return failure with message' do
      err_msg = /must be one of: alimony_paid, deductable_part_of_self_employment_taxes/
      expect(subject.call(input_params.merge(kind: 'kind')).errors.to_h[:kind].first).to match(err_msg)
    end
  end

  context 'valid params' do
    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end
end