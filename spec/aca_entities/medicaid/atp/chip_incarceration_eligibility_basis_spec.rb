# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/activity_date'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/status_valid_date_range'
require 'aca_entities/medicaid/atp/eligibility_basis_determination'
require 'aca_entities/medicaid/atp/chip_incarceration_eligibility_basis'

RSpec.describe ::AcaEntities::Medicaid::Atp::ChipIncarcerationEligibilityBasis,  dbclean: :around_each do

  let(:required_params) do
    {
      status_code: "Complete"
    }
  end

  let(:optional_params) do
    {
      status_indicator: true,
      ineligibility_reason_text: "123",
      determination:
        {
          activity_identification: { identification_id: "MET00000000001887090" },
          activity_date: { date_time: DateTime.now }
        }
    }
  end

  let(:all_params) { required_params.merge(optional_params)}

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

