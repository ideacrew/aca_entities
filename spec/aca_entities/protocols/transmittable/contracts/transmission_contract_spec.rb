# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmittable::Contracts::TransmissionContract do
  subject { described_class.new }

  let(:moment) { DateTime.now }

  let(:id) { '12345' }
  let(:transmission_name) { "verification_transmission" }
  let(:title) { "Verification Transmission Cool Title" }
  let(:description) { 'A dummy verification transmission' }
  let(:process_status) { { initial_state_key: :draft } }
  let(:started_at) { moment }
  let(:ended_at) { nil }
  let(:errors) { [] }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    { name: transmission_name, started_at: started_at, process_status: process_status, errors: errors }
  end

  let(:optional_params) do
    {
      id: id,
      title: title,
      description: description,
      ended_at: ended_at,
      timestamps: timestamps
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
        process_status: ['is missing'],
        errors: ['is missing']
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
