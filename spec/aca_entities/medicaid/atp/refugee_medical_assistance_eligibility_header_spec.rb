# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/refugee_medical_assistance_eligibility_header'

RSpec.describe ::AcaEntities::Medicaid::Atp::RefugeeMedicalAssistanceEligibilityHeader,
               dbclean: :around_each do

  let(:required_params) do
    {
      start_date: Date.today,
      medicaid_chip_state: 'DC'
    }
  end

  let(:all_params) do
    required_params.merge(
      status_indicator: true,
      ineligibility_reason: "reason for in eligibility",
      determination_date: DateTime.now,
      end_date: Date.today,
      medicaid_chip_county: "Washington",
      eligibility_establishment_system: "enroll_system"
    )
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
end
