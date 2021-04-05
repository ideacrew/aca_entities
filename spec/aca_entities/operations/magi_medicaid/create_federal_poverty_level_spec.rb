# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/libraries/magi_medicaid_library'

RSpec.describe ::AcaEntities::Operations::MagiMedicaid::CreateFederalPovertyLevel do
  describe 'with valid arguments' do
    let(:state_code) { 'ME' }
    let(:household_size) { 1 }
    let(:medicaid_year) { 2020 }
    let(:annual_poverty_guideline) { 12_000 }
    let(:annual_per_person_amount) { 1_000 }

    let(:required_params) do
      {
        state_code: state_code,
        household_size: household_size,
        medicaid_year: medicaid_year,
        annual_poverty_guideline: annual_poverty_guideline,
        annual_per_person_amount: annual_per_person_amount
      }
    end

    context "creates a new #{described_class} instance" do
      let(:result) { subject.call(required_params) }

      it 'should return success' do
        expect(result.success?).to be_truthy
      end
    end

    context 'invalid params' do
      before { @result = subject.call({}) }

      it 'should return a failure' do
        expect(@result.success?).to be_falsey
      end
    end
  end
end
