# frozen_string_literal: true
require 'spec_helper'

# require "../aca_entities/lib/aca_entities/contracts/financial/payment_transactions/payment_transaction_contract"

RSpec.describe ::AcaEntities::AsyncApi::Operations::FindConfigsByServiceName do

  describe "Find Configs" do

    let(:params) { {service_name: service_name } }
    let(:service_name) { 'medicaid_gateway' }

    subject { described_class.new.call(params) }

    context "with valid service name" do
    
      it 'should return array of configurations' do
        result = subject

        expect(result).to be_success
        expect(result.success).to be_a(Array)
      end
    end

    context "with invalid service name" do

      let(:service_name) { 'invalid_service_name' }

      it 'should raise an error' do
        result = subject
        expect(result).to be_failure
      end
    end

    context "with no service name" do
      let(:service_name) { nil }
      let(:async_api_key) { "asyncapi" }

      it "should return all schemas" do
        result = subject

        expect(result).to be_success
        output = result.success
        expect(output.first.keys[0]).to eq(async_api_key)
        expect(output.last.keys[0]).to eq(async_api_key)
      end
    end
  end
end
