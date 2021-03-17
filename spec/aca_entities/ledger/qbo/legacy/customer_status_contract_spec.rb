# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Qbo::Legacy::CustomerStatusContract do

  let(:required_params)    { 
    {
      "past_due": "0",
      "previous_balance": "1051.92",
      "new_charges": "350.64",
      "adjustments": "0",
      "payments": "-1051.92",
      "total_due": "350.64",
      "statement_date": Date.today.beginning_of_month,
      "adjustment_items": [
        {
          "amount": "100",
          "name": "Some name",
          "description": "BlueDental Preferred High",
          "posting_date": "01/03/2019",
          "is_passive_renewal": true
        }
      ],
      "payment_history": [
        {
          "amount": "1051.92",
          "reference_id": "3025768644",
          "paid_on": "2018-12-31:00:00",
          "method_kind": "ACH"
        },
        {
          "amount": "701.28",
          "reference_id": "3022648327",
          "paid_on": "2018-09-26:00:00",
          "method_kind":  "ACH"
        }
      ]
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
