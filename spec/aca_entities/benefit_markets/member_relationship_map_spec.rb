# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::MemberRelationshipMap do

  context "Given valid required parameters" do

    let(:contract)                  { AcaEntities::BenefitMarkets::PricingModels::MemberRelationshipMapContract.new }
    let(:required_params)           { { relationship_name: :employee, count: 1, operator: :== } }

    context "with all/required params" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new MemberRelationshipMap instance" do
        expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::MemberRelationshipMap
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end
  end
end