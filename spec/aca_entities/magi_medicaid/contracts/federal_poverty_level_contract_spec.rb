# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/libraries/magi_medicaid_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::FederalPovertyLevelContract do
  let(:state_code) { 'ME' }
  let(:household_size) { 1 }
  let(:annual_poverty_guideline) { 12_000 }
  let(:add_person_annual_amount) { 4_800 }
  let(:monthly_poverty_guideline) { 1_000 }
  let(:add_person_monthly_amount) { 400 }
  let(:effective_start_on) { Date.today - 1 }
  let(:effective_end_on) { Date.today }

  let(:required_params) do
    {
      state_code: state_code,
      household_size: household_size,
      annual_poverty_guideline: annual_poverty_guideline,
      add_person_annual_amount: add_person_annual_amount,
      monthly_poverty_guideline: monthly_poverty_guideline,
      add_person_monthly_amount: add_person_monthly_amount,
      effective_start_on: effective_start_on,
      effective_end_on: effective_end_on
    }
  end

  context 'Given one or more invalid paramaters are passed to the #{described_class} contract' do
    context 'and the effective_end_on precedes the effective_start_on date' do
      let(:effective_start_on) { Date.today }
      let(:invalid_effective_end_on) { effective_start_on - 1 }

      let(:invalid_effective_dates) do
        {
          efffective_start_on: effective_start_on,
          effective_end_on: invalid_effective_end_on
        }
      end

      let(:invalid_params) { required_params.merge! invalid_effective_dates }

      it 'should raise an error' do
        result = subject.call(invalid_params)

        expect(result.success?).to be_falsey
        expect(
          result.errors.messages.first.text
        ).to start_with 'must be after effective_start_on'
      end
    end

    context 'and an invalid state_code param is passed' do
      let(:lowcase_state_code) { { state_code: 'me' } }
      let(:invalid_params) { required_params.merge! lowcase_state_code }

      it 'should fail validation' do
        result = subject.call(invalid_params)

        expect(result.success?).to be_falsey
        expect(
          result.errors.messages.first.text
        ).to start_with 'must be one of: AL, AK'
      end
    end
  end

  context "Given all required, valid params, the #{described_class} contract" do
    it 'should pass validation' do
      result = subject.call(required_params)

      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end
end
