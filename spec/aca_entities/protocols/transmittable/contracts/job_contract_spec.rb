# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmittable::Contracts::JobContract do
  subject { described_class.new }

  let(:moment) { DateTime.now }
  let(:id) { '12345' }
  let(:job_id) { 'abc123'}
  let(:account) { { username: 'antman', first_name: 'Scott', last_name: 'Lang' } }
  let(:name) { :verification_job }

  let(:title) { name.to_s }
  let(:description) { 'A dummy verification job' }

  let(:publish_on) { moment.to_date }
  let(:expire_on) { moment.to_date + 1 }

  let(:started_at) { moment }
  let(:ended_at) { nil }

  let(:time_to_live) { 0 }
  let(:process_status) { { initial_state_key: :draft } }
  let(:transmissions) { [] }

  let(:allow_list) { [] }
  let(:deny_list) { [] }
  let(:errors) { [] }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      name: name,
      job_id: job_id,
      started_at: started_at,
      process_status: process_status,
      time_to_live: time_to_live,
      publish_on: publish_on,
      errors: errors
    }
  end

  let(:optional_params) do
    {
      id: id,
      account: account,
      title: title,
      description: description,
      ended_at: ended_at,
      expire_on: expire_on,
      transmissions: transmissions,
      allow_list: allow_list,
      deny_list: deny_list,
      timestamps: timestamps
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Call contract with valid params' do
    context 'Call contract with required params only' do
      it 'should pass validation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Call contract with all params (required and optional)' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Call the contract with empty params' do
    let(:error_message) do
      {
        name: ['is missing'],
        started_at: ['is missing'],
        process_status: ['is missing'],
        time_to_live: ['is missing'],
        publish_on: ['is missing'],
        errors: ['is missing'],
        job_id: ['is missing']
      }
    end

    it 'should fail validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Validate #ended_at' do
    context 'when #ended_at is before #started_at' do
      let(:ended_at) { started_at - 1 }
      let(:params) { all_params.merge(ended_at: ended_at) }

      it 'should fail validation' do
        result = subject.call(params)
        expect(result.failure?).to be_truthy
        expect(result.errors.to_h).to eq({ ended_at: ['must be after started_at'] })
      end
    end

    context 'when #ended_at is after #started_at' do
      let(:ended_at) { started_at + 1 }
      let(:params) { all_params.merge(ended_at: ended_at) }

      it 'should pass validation' do
        result = subject.call(params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Validate #allow_list and #deny_list' do
    let(:transaction_name) { :verification_transaction }
    let(:transaction_started_at) { moment }
    let(:process_status) { { initial_state_key: :draft } }
    let(:transaction_process_states) { { event: "dummy event", message: "dummy transaction", started_at: moment } }
    let(:transaction_errors) { [] }

    let(:transaction_params) do
      {
        started_at: transaction_started_at,
        process_status: process_status,
        errors: transaction_errors
      }
    end

    context 'allow_list includes a subject entity' do
      let(:allow_transaction_params) { transaction_params.merge(name: :allow_transaction) }
      let(:allow_list_subject) { { transactions: [allow_transaction_params] } }
      let(:allow_list) { [allow_list_subject] }
      let(:allow_list_params) { all_params.merge(allow_list: allow_list) }

      it 'should pass validation' do
        result = subject.call(allow_list_params)
        expect(result.success?).to be_truthy
        expect(result.to_h[:allow_list]).to eq allow_list
      end
    end

    context 'deny_list includes a subject entity' do
      let(:deny_transaction_params) { transaction_params.merge(name: :deny_transaction) }
      let(:deny_list_subject) { { transactions: [deny_transaction_params] } }
      let(:deny_list) { [deny_list_subject] }
      let(:deny_list_params) { all_params.merge(deny_list: deny_list) }

      it 'should pass validation' do
        result = subject.call(deny_list_params)
        expect(result.success?).to be_truthy
        expect(result.to_h[:deny_list]).to eq deny_list
      end
    end
  end

  context 'Validate #transmissions' do
    context 'when #transmissions are empty' do
      let(:transmission) { [] }
      let(:params) { all_params.merge(transmissions: transmission) }

      it 'should pass validation' do
        result = subject.call(params)
        expect(result.success?).to be_truthy
        expect(result.to_h[:deny_list]).to eq deny_list
      end
    end

    context 'Calling the contract with a transmission present' do
      let(:moment) { DateTime.now }

      let(:id) { '12345' }

      let(:transmission_name) { "verification transmission" }
      let(:title) { "Verification Transmission of Whatever" }
      let(:description) { 'A dummy verification transmission' }

      let(:started_at) { moment }
      let(:process_status) { { initial_state_key: :draft } }
      let(:errors) { [] }

      context 'and that transmission is valid' do
        let(:transmission) do
          {
            name: transmission_name,
            title: title,
            description: description,
            started_at: started_at,
            process_status: process_status,
            errors: errors
          }
        end

        let(:params) { all_params.merge(transmissions: [transmission]) }

        it 'should pass validation' do
          result = subject.call(params)
          expect(result.success?).to be_truthy
          expect(result.to_h).to eq params
        end

        context 'and that transmission is invalid' do
          let(:transmission) { { id: id } }
          let(:params) { all_params.merge(transmissions: [transmission]) }
          let(:error_message) do
            {
              transmissions:
                {
                  0 =>
                    {
                      name: ['is missing'],
                      started_at: ['is missing'],
                      process_status: ['is missing'],
                      errors: ['is missing']
                    }
                }
            }
          end

          it 'should fail validation' do
            result = subject.call(params)
            expect(result.failure?).to be_truthy
            expect(result.errors.to_h).to eq error_message
          end
        end
      end
    end
  end
end
