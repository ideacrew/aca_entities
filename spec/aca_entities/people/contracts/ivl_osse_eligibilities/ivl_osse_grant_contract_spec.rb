# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::People::IvlOsseEligibilities::IvlOsseGrantContract do
  let(:key) { :hc4cc }
  let(:title) { 'childcare subsidy' }
  let(:value) { { title: title, key: key } }
  let(:description) { 'childcare subsidy eligibility' }
  let(:state_histories) do
    [
      {
        effective_on: Date.today,
        is_eligible: true,
        from_state: 'draft',
        to_state: 'eligible',
        transition_at: DateTime.now
      }
    ]
  end

  let(:required_params) do
    { key: key, title: title, value: value, state_histories: state_histories }
  end

  let(:optional_params) { { description: description } }

  let(:optional_params) do
    {
      event: 'mark_eligible',
      comment: 'hc4cc eligibility submitted',
      reason: 'childcare subsidy'
    }
  end

  let(:error_message) do
    { value: ['is missing'], state_histories: ['is missing'] }
  end

  let(:result) { double(success?: true) }

  context 'Given invalid required parameters' do
    context 'sending with missing parameters should fail validation with :errors' do
      let(:invalid_params) { required_params.except(:value, :state_histories) }
      it { expect(subject.call(invalid_params).failure?).to be_truthy }
      it do
        expect(subject.call(invalid_params).errors.to_h).to eq error_message
      end
    end

    context 'when state histories invalid' do
      context 'it should fail validation' do
        let(:state_histories) do
          [
            {
              effective_on: Date.today,
              is_eligible: true,
              from_state: 'draft',
              to_state: 'eligible'
            }
          ]
        end

        let(:invalid_params) { required_params }
        let(:error_message) do
          {
            state_histories: {
              0 => [
                {
                  text: 'invalid state history',
                  error: {
                    transition_at: ['is missing']
                  }
                }
              ]
            }
          }
        end

        it { expect(subject.call(invalid_params).failure?).to be_truthy }
        it do
          expect(subject.call(invalid_params).errors.to_h).to eq error_message
        end
      end
    end

    context 'when value passed is invalid' do
      context 'it should fail validation' do
        let(:value) { { title: title } }
        let(:invalid_params) { required_params }
        let(:error_message) { { value: { key: ['is missing'] } } }

        it { expect(subject.call(invalid_params).failure?).to be_truthy }
        it do
          expect(subject.call(invalid_params).errors.to_h).to eq error_message
        end
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
