# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmittable::Contracts::SubjectContract do

  before :each do
    dummy_transmission_klass =
      Class.new(super_class: Transmittable::Transmission) do
        # action here
      end
    stub_const('Dummy::Transmission', dummy_transmission_klass)

    dummy_transaction_subject_klass =
      Class.new(super_class: Dry::Struct) do
        include 'Transmittable::Subject'

        attribute :type, Types::String.meta(omittable: false)
        attribute :message_text, Types::String.meta(omittable: false)
      end
    stub_const('Dummy::Transaction', dummy_transaction_subject_klass)
  end

  let(:transactions) { [] }
  let(:required_params) { { transactions: transactions } }
  let(:optional_params) { Hash.new }
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
    let(:error_message) { { transactions: ['is missing'] } }

    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Calling the contract with a transaction present' do
    let(:moment) { DateTime.now }

    let(:id) { '12345' }
    let(:transaction_id) { 'xyz210'}

    let(:name) { :verification_transaction }
    let(:title) { name.to_s }
    let(:description) { 'A dummy verification transaction' }

    let(:started_at) { moment }
    let(:status) { :initial }
    let(:process_states) { [] }
    let(:errors) { [] }

    context 'and that transaction is valid' do
      let(:transaction) do
        {
          transaction_id: transaction_id,
          name: name,
          title: title,
          description: description,
          started_at: started_at,
          status: status,
          process_states: process_states,
          errors: errors
        }
      end

      let(:params) { all_params.merge(transactions: [transaction]) }

      it 'should pass validation' do
        result = subject.call(params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq params
      end

      context 'and that transaction is invalid' do
        let(:transaction) { { transaction_id: transaction_id } }
        let(:params) { all_params.merge(transactions: [transaction]) }
        let(:error_message) do
          {
            transactions:
              {
                0 =>
                  {
                    name: ['is missing'],
                    started_at: ['is missing'],
                    status: ['is missing'],
                    process_states: ['is missing'],
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
