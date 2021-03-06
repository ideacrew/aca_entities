# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/magi_household_size_basis'

RSpec.describe ::AcaEntities::Medicaid::Atp::MagiHouseholdSizeBasis,  dbclean: :around_each do

  let(:required_params) {{ status_code: "200" }}

  let(:all_params) do
    required_params.merge(
      status_indicator: true,
      status_determination_date: DateTime.now,
      inconsistency_reason: "reason for in consistency",
      ineligibility_reason: "reason for in eligibility",
      status_source_code: "source code"
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
