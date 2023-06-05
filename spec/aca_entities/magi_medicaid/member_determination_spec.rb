# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::MemberDetermination do

  before do
    contract_params = ::AcaEntities::MagiMedicaid::Contracts::MemberDeterminationContract.new.call(member_determination).to_h
    @result = described_class.new(contract_params)
  end

  context 'eligible for Medicaid/CHIP' do
    context 'due to mitc override for applicant who is not lawfully present and pregnant' do
      let(:member_determination) do
        { kind: 'Medicaid/CHIP Determination',
          is_eligible: true,
          determination_reasons: [:mitc_override_not_lawfully_present_pregnant],
          eligibility_overrides: [{
            override_rule: 'not_lawfully_present_pregnant',
            override_applied: true
          }] }
      end

      it 'should return MemberDetermination entity object' do
        expect(@result).to be_a(described_class)
      end

      it 'should return all keys of MemberDetermination' do
        expect(@result.to_h.keys).to eq(member_determination.keys)
      end
    end
  end
end
