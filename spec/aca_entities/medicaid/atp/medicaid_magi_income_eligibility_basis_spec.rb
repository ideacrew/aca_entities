# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/eligibility_basis_determination'
require 'aca_entities/medicaid/atp/medicaid_magi_income_eligibility_basis'

RSpec.describe ::AcaEntities::Medicaid::Atp::MedicaidMagiIncomeEligibilityBasis,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) do
      {
        eligibility_basis_status_code: "Complete"
      }
    end

    let(:optional_params) do
      {
        status_indicator: true,
        ineligibility_reason_text: "123",
        eligibility_basis_determination:
          {
            activity_identification: { identification_id: "MET00000000001887090" },
            activity_date: { date_time: DateTime.now }
          },
        state_threshold_fpl_percent: "116"
      }
    end

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end
end

