# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmittable::Contracts::SubjectContract do
  context 'Calling an Entity contract with a subject_transactions param' do

    context 'Calling contract with Valid params' do
      let(:transaction_key) { :verification_transaction }
      let(:transaction_status) { :initial }
      let(:transaction_process_status) { { initial_state_key: :draft } }
      let(:transaction_started_at) { DateTime.now }
      let(:transaction_errors) { [] }
      let(:transactions_transmissions_transmissions) { { transmission: { key: :fake_key }, transactions: [{ key: :fake_key }] } }
      let(:transactions_transmissions_transactions) { { transaction: { key: :fake_key }, transmissions: [{ key: :fake_key }] } }
      let(:transactions_transmissions) do
        [{ transmissions: transactions_transmissions_transmissions, transactions: transactions_transmissions_transactions }]
      end

      let(:transaction) do
        {
          key: transaction_key,
          process_status: transaction_process_status,
          started_at: transaction_started_at,
          errors: transaction_errors,
          transactions_transmissions: transactions_transmissions
        }
      end

      let(:required_params) {{ transactions: [transaction] }}

      it 'should validate passed attribute values and also included transactions param' do
        result = described_class.new.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end
  end
end
