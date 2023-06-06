# frozen_string_literal: true

require 'spec_helper'

# shared_examples_for 'SubjectContract' do
#   describe "The Transmittable Subject"
#   # The Subject's domain model class
#   let(:entity) { described_class }

#   it 'Entity model has a transactions attribute' do
#     expect(entity).to respond_to(:transactions)
#   end

#   it 'Transactions pass validation'
# end

RSpec.describe AcaEntities::Protocols::Transmittable::Contracts::SubjectContract do
  context 'Calling an Entity contract with a subject_transactions param' do

    before :each do
      dummy_subject_contract_klass =
        Class.new(AcaEntities::Protocols::Transmittable::Contracts::Contract) do
          params do
            required(:id).filled(:string)
            required(:name).filled(:symbol)
            required(:title).filled(:string)
            required(:description).filled(:string)
            required(:subject_transactions).schema(AcaEntities::Protocols::Transmittable::Contracts::SubjectContract.new)
          end
        end
      stub_const('Dummy::EntityContract', dummy_subject_contract_klass)
    end

    context 'Calling contract with Valid params' do
      let(:transaction_id) { 'subject_12345' }
      let(:transaction_name) { :verification_transaction }
      let(:transaction_status) { :initial }
      let(:transaction_process_states) { [] }
      let(:transaction_started_at) { DateTime.now }
      let(:transaction_errors) { [] }

      let(:transaction) do
        {
          name: transaction_name,
          started_at: transaction_started_at,
          status: transaction_status,
          process_states: transaction_process_states,
          errors: transaction_errors
        }
      end

      let(:entity_id) { 'entity_0987' }
      let(:entity_name) { :entity_name }
      let(:entity_title) { entity_name.to_s }
      let(:entity_description) { "An Entity that is this Transmittable's Subject" }
      let(:subject_transactions) { { transactions: [transaction] } }

      let(:required_params) do
        {
          id: entity_id,
          name: entity_name,
          title: entity_title,
          description: entity_description,
          subject_transactions: subject_transactions
        }
      end

      let(:entity_contract) { described_class } # the class that includes the subject
      let(:entity_contract_klass) { subject } # the class that includes the subject

      subject { Dummy::EntityContract.new }

      it 'should validate passed attribute values and also included transactions param' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h[:subject_transactions]).to eq subject_transactions
        expect(result.to_h).to eq required_params
      end
    end
  end
end






