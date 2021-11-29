# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/household_member_reference'
require 'aca_entities/medicaid/atp/medicaid_household'

RSpec.describe ::AcaEntities::Medicaid::Atp::MedicaidHousehold,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      {
        id: "mh123",
        effective_person_quantity: 1,
        income_above_highest_applicable_magi_standard_indicator: true,
        household_member_references: [{ ref: "pe123" }],
        household_size_quantity: 1
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
end

