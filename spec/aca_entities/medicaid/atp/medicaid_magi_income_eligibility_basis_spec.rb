# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/activity_date'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/status_valid_date_range'
require 'aca_entities/medicaid/atp/eligibility_basis_determination'
require 'aca_entities/medicaid/atp/eligibility_basis'
require 'aca_entities/medicaid/atp/income_compatibility_determination'
require 'aca_entities/medicaid/atp/income_compatibility'
require 'aca_entities/medicaid/atp/medicaid_magi_income_eligibility_basis'

RSpec.describe ::AcaEntities::Medicaid::Atp::MedicaidMagiIncomeEligibilityBasis,  dbclean: :around_each do

  let(:required_params) do
    {
      status_code: "Complete"
    }
  end

  let(:optional_params) do
    {
      status_indicator: true,
      status_valid_date_range:
        {
          start_date: { date: Date.today },
          end_date: { date: Date.today }
        },
      ineligibility_reason_text: "n/a",
      inconsistency_reason_text: "n/a",
      pending_reason_text: "n/a",
      determination:
        {
          activity_identification: { identification_id: "MET00000000001887090" },
          activity_date: { date_time: DateTime.now }
        },
      state_threshold_fpl_percent: "0",
      income_compatibility:
        {
          verification_indicator: true,
          inconsistency_reason_text: "123",
          compatibility_determination:
            {
              activity_identification: { identification_id: "MET00000000001887090" },
              activity_date: { date_time: DateTime.now }
            },
          verification_method: "1"
        }
    }
  end

  let(:all_params) { required_params.merge(optional_params)}

  it 'should inherit from EligibilityBasis class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Atp::EligibilityBasis
  end

  context 'success case' do
    context 'with required params' do
      it 'should initialize and return passed params' do
        result = described_class.new(required_params)
        expect(result).to be_a described_class
        expect { result }.not_to raise_error
        expect(result.to_h).to eq required_params
      end
    end

    context 'with all params' do
      it 'should initialize and return passed params' do
        result = described_class.new(all_params)
        expect(result).to be_a described_class
        expect { result }.not_to raise_error
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'failure case' do
    context 'without required params' do
      it 'should raise missing key error' do
        expect { subject }.to raise_error(Dry::Struct::Error, /:status_code is missing in Hash input/)
      end
    end
  end
end

