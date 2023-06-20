# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::EligibilityOverride do

  before do
    contract_params = ::AcaEntities::MagiMedicaid::Contracts::EligibilityOverrideContract.new.call(eligibility_override).to_h
    @result = described_class.new(contract_params)
  end

  context 'eligible for Medicaid/CHIP' do
    context 'due to mitc override for applicant who is not lawfully present and pregnant' do
      let(:eligibility_override) do
        { override_rule: 'not_lawfully_present_pregnant',
          override_applied: true }
      end

      it 'should return EligibilityOverride entity object' do
        expect(@result).to be_a(described_class)
      end

      it 'should return all keys of EligibilityOverride' do
        expect(@result.to_h.keys).to eq(eligibility_override.keys)
      end
    end
  end
end
