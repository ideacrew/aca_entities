# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligible::StateHistoryContract do
  let(:required_params) do
    {
      effective_on: Date.today,
      is_eligible: true,
      from_state: :draft,
      to_state: :eligible,
      transition_at: DateTime.now
    }
  end

  let(:optional_params) do
    {
      event: :mark_eligible,
      comment: 'hc4cc eligibility submitted',
      reason: 'childcare subsidy',
      updated_by: "gid://enroll/User/66c4f31a90be7cedfb877fe7"
    }
  end

  let(:error_message) do
    { is_eligible: ['is missing'], transition_at: ['is missing'] }
  end

  let(:result) { double(success?: true) }

  context 'Given invalid required parameters' do
    context 'sending with missing parameters should fail validation with :errors' do
      let(:invalid_params) do
        required_params.except(:is_eligible, :transition_at)
      end
      it { expect(subject.call(invalid_params).failure?).to be_truthy }
      it do
        expect(subject.call(invalid_params).errors.to_h).to eq error_message
      end
    end
  end

  context 'Given valid required parameters' do
    context 'with a required only' do
      it 'should pass validation' do
        expect(subject.call(required_params).success?).to be_truthy
        expect(subject.call(required_params).to_h).to eq required_params
      end
    end
  end
end
