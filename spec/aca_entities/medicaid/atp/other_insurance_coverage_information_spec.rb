# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/other_insurance_coverage_information'

RSpec.describe ::AcaEntities::Medicaid::Atp::OtherInsuranceCoverageInformation do

  describe 'with valid arguments' do
    let(:input_params) do
      { lost_insurance_within_waiting_period: true,
        coverage_ended_reason_code: 'UnpaidPremium',
        enrolled_in_other_insurance: false,
        has_access_to_state_employee_health_plan: false }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
