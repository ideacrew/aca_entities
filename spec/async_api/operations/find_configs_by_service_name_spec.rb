# frozen_string_literal: true

require 'spec_helper'
# require "../aca_entities/lib/aca_entities/contracts/financial/payment_transactions/payment_transaction_contract"

RSpec.describe ::AcaEntities::AsyncApi::Operations::FindConfigsByServiceName do

  describe "Find Configs" do

    let(:params) { { service_name: service_name } }
    let(:service_name) { 'medicaid_gateway' }
    let(:async_api_key) { "asyncapi" }

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

      it "should return all schemas" do
        result = subject

        expect(result).to be_success
        output = result.success
        expect(output.first.keys[0]).to eq(async_api_key)
        expect(output.last.keys[0]).to eq(async_api_key)
      end
    end

    context "with requested all schemas" do
      let(:params) { nil }

      it "should return all schemas" do
        result = subject

        expect(result).to be_success
        output = result.success

        expect(output.first.keys[0]).to eq(async_api_key)
        expect(output.last.keys[0]).to eq(async_api_key)
      end
    end

    # rubocop:disable Lint/Void
    context "with service name and protocol" do
      let(:params) { { service_name: 'medicaid_gateway', protocol: protocol } }

      context "when http protocol passed" do

        let(:protocol) { 'http' }

        it "should return all http schemas" do
          result = subject

          expect(result).to be_success
          resources = result.success
          expect(resources).not_to be_empty
          resources.each do |resource|
            resource['servers']['production']['protocol'] == params[:protocol].to_s
          end
        end
      end

      context "when amqp protocol passed" do

        let(:protocol) { 'amqp' }

        it "should return all amqp schemas" do
          result = subject

          expect(result).to be_success
          resources = result.success
          expect(resources).not_to be_empty
          resources.each do |resource|
            resource['servers']['production']['protocol'] == params[:protocol].to_s
          end
        end
      end
    end
    # rubocop:enable Lint/Void
  end
end
