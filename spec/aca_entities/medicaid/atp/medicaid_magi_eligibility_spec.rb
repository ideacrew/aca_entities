# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/status_valid_date_range'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/activity_date'
require 'aca_entities/medicaid/atp/eligibility_basis_determination'
require 'aca_entities/medicaid/atp/eligibility_basis'
require 'aca_entities/medicaid/atp/eligibility_date_range'
require 'aca_entities/medicaid/atp/eligibility_determination'
require 'aca_entities/medicaid/atp/income_compatibility_determination'
require 'aca_entities/medicaid/atp/income_compatibility'
require 'aca_entities/medicaid/atp/medicaid_magi_income_eligibility_basis'
require 'aca_entities/medicaid/atp/medicaid_magi_eligibility'

RSpec.describe ::AcaEntities::Medicaid::Atp::MedicaidMagiEligibility,  dbclean: :around_each do

  let(:required_params) { {} }

  let(:optional_params) do
    {
      date_range:
        {
          start_date: { date: Date.today },
          end_date: { date: Date.today }
        },
      eligibility_determination:
        {
          activity_identification: { identification_id: "MET00000000001887090" }
        },
      eligibility_indicator: false,
      eligibility_reason_text: "a-reason",
      income_eligibility_basis: { status_code: "Pending" }
    }
  end

  let(:all_params) { required_params.merge(optional_params)}

  it 'should initialize' do
    expect(described_class.new(all_params)).to be_a described_class
  end

  it 'should not raise error' do
    expect { described_class.new(all_params) }.not_to raise_error
  end

  context 'with only optional parameters' do
    it 'should contain all optional keys and values' do
      result = described_class.new(optional_params)
      expect(result.to_h).to eq optional_params
    end
  end
end

