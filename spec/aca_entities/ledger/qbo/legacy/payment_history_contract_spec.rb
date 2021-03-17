# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Qbo::Legacy::PaymentHistoryContract do

  let(:required_params)    { 
    {
      "amount": "1051.92",
      "reference_id": "3025768644",
      "paid_on": "2018-12-31:00:00",
      "method_kind": "ACH"
    }
  }

  context "Given invalid parameter scenarios" do
    context "with empty parameters" do
      it 'should list error for every required parameter' do
        result = subject.call({})

        expect(result.success?).to be_falsey
        expect(result.errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context "Given valid parameters" do

    context "and required parameters only" do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
    end
  end
end
