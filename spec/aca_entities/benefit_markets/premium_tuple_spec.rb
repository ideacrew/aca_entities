# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::PremiumTuple do

  context "Given valid required parameters" do

    let(:contract)           { AcaEntities::BenefitMarkets::Products::PremiumTupleContract.new }
    let(:required_params)    { { age: 20, cost: 227.07 } }

    context "with all/required params" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new PremiumTuple instance" do
        expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::PremiumTuple
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end
  end
end