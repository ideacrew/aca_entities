# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::IncomeContract,  dbclean: :after_each do
  let(:required_params) do
    { kind: 'alimony_and_maintenance',
      amount: 100.67,
      frequency_kind: 'Weekly',
      start_on: Date.today.prev_year.to_s }
  end
  let(:optional_params) do
    { title: 'title',
      wage_type: 'wage_type',
      hours_per_week: 20,
      amount_tax_exempt: 0.0,
      end_on: nil,
      is_projected: false,
      employer: {},
      has_property_usage_rights: false,
      submitted_at: DateTime.now.to_s }
  end

  context 'valid params' do
    let(:all_params) { required_params.merge(optional_params) }

    it 'should return success' do
      expect(subject.call(all_params)).to be_success
    end
  end

  context 'invalid params' do
    context 'no params' do
      before do
        @result = subject.call({})
      end

      it 'should return failure' do
        expect(@result).to be_failure
      end

      it 'should return a failure with error messages' do
        err_msg = { amount: ['is missing'], frequency_kind: ['is missing'], kind: ['is missing'], start_on: ['is missing'] }
        expect(@result.errors.to_h).to eq(err_msg)
      end
    end

    context 'invalid kind' do
      before do
        @result = subject.call(required_params.merge({ kind: 'kind' }))
      end

      it 'should return failure with error messages' do
        err_msg = /must be one of: alimony_and_maintenance, american_indian_and_alaskan_native/
        expect(@result.errors.to_h[:kind].first).to match(err_msg)
      end
    end

    context 'invalid frequency_kind' do
      before do
        @result = subject.call(required_params.merge({ frequency_kind: 'frequency_kind' }))
      end

      it 'should return failure with error messages' do
        err_msg = /must be one of: Weekly, Monthly/
        expect(@result.errors.to_h[:frequency_kind].first).to match(err_msg)
      end
    end
  end
end
