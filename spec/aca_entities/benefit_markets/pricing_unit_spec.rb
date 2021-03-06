# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::PricingUnit do

  context "Given valid required parameters" do

    let(:contract)         { AcaEntities::BenefitMarkets::PricingModels::PricingUnitContract.new }
    let(:required_params)  { { name: 'employee', display_name: 'Employee Only', order: 1 } }

    context "with all/required params" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new PricingUnit instance" do
        expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::PricingUnit
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end
  end
end