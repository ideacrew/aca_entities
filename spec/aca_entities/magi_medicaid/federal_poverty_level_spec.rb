# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::FederalPovertyLevel do
  describe 'with valid arguments' do
    let(:state_code) { 'me' }
    let(:household_size) { 1 }
    let(:medicaid_year) { 2019 }
    let(:annual_poverty_guideline) { 12_000 }
    let(:annual_per_person_amount) { 4_800 }
    let(:monthly_poverty_guideline) { 1_000 }
    let(:monthly_per_person_amount) { 400 }
    let(:aptc_effective_start_on) { Date.today - 1 }
    let(:aptc_effective_end_on) { Date.today }

    let(:required_params) do
      {
        state_code: state_code,
        household_size: household_size,
        medicaid_year: medicaid_year,
        annual_poverty_guideline: annual_poverty_guideline,
        annual_per_person_amount: annual_per_person_amount,
        monthly_poverty_guideline: monthly_poverty_guideline,
        monthly_per_person_amount: monthly_per_person_amount,
        aptc_effective_start_on: aptc_effective_start_on,
        aptc_effective_end_on: aptc_effective_end_on
      }
    end

    let(:optional_params) { {} }

    context "Given all required, valid params, the #{described_class} entity" do
      it 'should initialize' do
        expect(described_class.new(required_params)).to be_a described_class
      end
      it 'should not raise error' do
        expect { described_class.new(required_params) }.not_to raise_error
      end
      it 'and entity values should match the passed params' do
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end

    context 'Given one or more missing required params' do
      it 'should raise error' do
        expect { described_class.new }.to raise_error(
          Dry::Struct::Error,
          /:state_code is missing in Hash input/
        )
      end
    end
  end
end
