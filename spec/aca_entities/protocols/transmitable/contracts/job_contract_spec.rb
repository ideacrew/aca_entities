# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmitable::Contracts::JobContract do
  subject { described_class.new }

  let(:moment) { DateTime.now }

  let(:id) { '12345' }
  let(:job_id) { 'abc123'}
  let(:account) { { username: 'antman', first_name: 'Scott', last_name: 'Lang' } }
  let(:name) { :verification_job }

  let(:title) { name.to_s }
  let(:description) { 'A dummy verification job' }

  let(:started_at) { moment }
  let(:ended_at) { nil }

  let(:time_to_live) { 0 }
  let(:status) { :initial }
  let(:process_states) { []}
  let(:transmissions) { []}
  let(:transmissions) { []}
  let(:errors) { []}
  let(:allow_list) { []}
  let(:deny_list) { [] }

  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    { name: name, started_at: started_at, status: status, process_states: process_states }
  end

  let(:optional_params) do
    {
      id: id,
      job_id: job_id,
      account: account,
      title: title,
      description: description,
      ended_at: ended_at,
      time_to_live: time_to_live,
      errors: errors,
      allow_list: allow_list,
      deny_list: deny_list,
      timestamps: timestamps,
      transmissions: transmissions
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
    context 'Calling the contract with required params' do
      it 'should pass validation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Calling the contract with all params' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        name: ['is missing'],
        started_at: ['is missing'],
        status: ['is missing'],
        process_states: ['is missing']
      }
    end

    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Validating the ended_at' do
    context 'when ended_at is before started_at' do
      let(:ended_at) { started_at - 1 }

      it 'should fail validation' do
        result = subject.call(all_params)
        expect(result.failure?).to be_truthy
        expect(result.errors.to_h).to eq({ ended_at: ['must be after started_at'] })
      end
    end

    context 'when ended_at is after started_at' do
      let(:ended_at) { started_at + 1 }

      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
