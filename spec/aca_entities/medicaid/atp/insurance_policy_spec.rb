# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/insurance_policy_applied_effective_date_range'
require 'aca_entities/medicaid/atp/insurance_premium'
require 'aca_entities/medicaid/atp/medicaid_identification'
require 'aca_entities/medicaid/atp/chip_identification'
require 'aca_entities/medicaid/atp/insurance_member'
require 'aca_entities/medicaid/atp/insurance_policy_identification'
require 'aca_entities/medicaid/atp/insurance_policy'

RSpec.describe ::AcaEntities::Medicaid::Atp::InsurancePolicy,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      {
        member:
          {
            chip_identification: { identification_id: "id123" },
            medicaid_identification: { identification_id: "id123" }
          },
        policy_id: { identification_id: "MET00000000001887090" },
        premium:
          {
            amount: 0.00,
            aptc_amount: 0.00,
            subscriber_amount: 0.00
          },
        source_code: "Private",
        applied_effective_date_range:
          {
            start_date: { date: Date.today },
            end_date: { date: Date.today }
          }
      }
    end

    let(:all_params) { required_params.merge(optional_params) }

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
end

