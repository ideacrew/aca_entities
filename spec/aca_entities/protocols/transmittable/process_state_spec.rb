# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmittable::ProcessState do
  let(:moment) { DateTime.now }

  context 'Given valid required params' do
    let(:event) { { process_completed: { payload: { name: 'request_to_resource' } } } }
    let(:message) { 'this sets the initial state to: requested' }
    let(:state_key) { :requested }
    let(:started_at) { moment }
    let(:ended_at) { moment + 1 }
    let(:seconds_in_state) { 3 }

    let(:required_params) do
      {
        state_key: state_key,
        started_at: started_at,
        seconds_in_state: seconds_in_state
      }
    end

    let(:subject) { described_class.new(required_params) }

    it 'should initialize and be valid' do
      expect(subject.to_h).to eq required_params
    end

    context 'and valid optional params' do
      let(:optional_params) do
        {
          event: event,
          message: message,
          state_key: state_key,
          started_at: started_at,
          ended_at: ended_at
        }
      end

      let(:all_params) { required_params.merge(optional_params) }
      let(:subject) { described_class.new(all_params) }

      it 'should initialize and be valid' do
        expect(subject.to_h).to eq all_params
      end
    end
  end
end
