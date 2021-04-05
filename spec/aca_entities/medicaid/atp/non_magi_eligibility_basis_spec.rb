# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/non_magi_eligibility_basis'

RSpec.describe ::AcaEntities::Medicaid::Atp::NonMagiEligibilityBasis, dbclean: :around_each do

  let(:required_params) {{}}

  let(:all_params) do
    required_params.merge(
      person_disabled: true,
      person_disable_status_code: "status code",
      medicare_entitlement: false,
      medicare_entitlement_status_code: 'code'
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
