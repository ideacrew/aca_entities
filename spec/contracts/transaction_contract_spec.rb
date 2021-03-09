# frozen_string_literal: true

require "../aca_entities/lib/aca_entities/contracts/transaction_contract"

RSpec.describe ::AcaEntities::Contracts::TransactionContract,  dbclean: :after_each do

  describe "Transaction contract" do

    context "calling with params values as nil" do
      let(:invalid_params) { { enrollment_id: '', carrier_id: '', enrollment_effective_date: '' } }
      let(:error_message) do
        { :carrier_id => ["Carrier id is blank"],
          :enrollment_effective_date => ["must be a date"],
          :enrollment_id => ["Enrollment id is blank"] }
      end

      it 'should be a container-ready operation' do
        expect(subject.respond_to?(:call)).to be_truthy
      end

      it 'should return Dry::Validation::Result object' do
        expect(subject.call(invalid_params)).to be_a ::Dry::Validation::Result
      end

      it 'should throw errors' do
        expect(subject.call(invalid_params).errors.to_h).to eq error_message
      end
    end

    context "sending with missing keys should return errors" do

      let(:invalid_params) { {} }
      let(:error_message) do
        { :carrier_id => ["is missing"],
          :enrollment_effective_date => ["is missing"],
          :enrollment_id => ["is missing"] }
      end

      it 'should throw errors' do
        expect(subject.call(invalid_params).errors.to_h).to eq error_message
      end
    end

    context "sending with all keys and values should not errors" do

      let(:valid_params) do
        { :enrollment_id => "test",
          :carrier_id => "test",
          :enrollment_effective_date => Date.today }
      end

      it 'should return Dry::Validation::Result object' do
        expect(subject.call(valid_params)).to be_a ::Dry::Validation::Result
      end

      it 'should not return any errors' do
        expect(subject.call(valid_params).errors.to_h).to be_empty
      end
    end

  end
end
