# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::EligibilityOverrideContract do
  let(:required_params) do
    {
      override_rule: 'not_lawfully_present_pregnant',
      override_applied: true
    }
  end

  let(:optional_params) { {} }

  let(:all_params) { required_params.merge(optional_params) }

  context 'valid params' do
    context 'override_rule is a valid ::AcaEntities::MagiMedicaid::Types::EligibilityOverrideRule' do
      it 'should return success' do
        expect(subject.call(all_params)).to be_success
      end
    end
  end

  context 'invalid params' do
    context 'override_rule is NOT a valid ::AcaEntities::MagiMedicaid::Types::EligibilityOverrideRule' do
      before do
        all_params.merge!({ override_rule: 'invalid' })
      end

      it 'should return failure' do
        expect(subject.call(all_params).failure?).to be_truthy
      end
    end
  end
end
