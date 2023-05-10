# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::MemberDeterminationContract do
  let(:required_params) { {} }

  let(:optional_params) do
    {
      kind: 'Medicaid/CHIP Determination',
      is_eligible: true,
      determination_reasons: [:mitc_override_not_lawfully_present_pregnant]
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'valid params' do
    context 'kind is a valid ::AcaEntities::MagiMedicaid::Types::MemberDeterminationKind' do
      it 'should return success' do
        expect(subject.call(all_params)).to be_success
      end
    end

    context 'determination_reasons contains a symbol' do
      it 'should return success' do
        expect(subject.call(all_params)).to be_success
      end
    end
  end

  context 'invalid params' do
    context 'kind is NOT a valid ::AcaEntities::MagiMedicaid::Types::MemberDeterminationKind' do
      before do
        all_params.merge!({ kind: 'invalid' })
      end

      it 'should return failure' do
        expect(subject.call(all_params).failure?).to be_truthy
      end
    end
  end
end
