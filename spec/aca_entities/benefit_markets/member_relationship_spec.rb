# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::MemberRelationship do

  context "Given valid required parameters" do

    let(:contract)           { AcaEntities::BenefitMarkets::PricingModels::MemberRelationshipContract.new }
    let(:required_params)    do
      { relationship_name: :employee, relationship_kinds: [{}], age_threshold: nil, age_comparison: nil, disability_qualifier: nil }
    end

    context "with required only" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new MemberRelationship instance" do
        expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::MemberRelationship
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end

    context "with all params" do
      let(:all_params) {required_params.merge({ age_threshold: 26, age_comparison: :age_comparison, disability_qualifier: true })}

      it "contract validation should pass" do
        expect(contract.call(all_params).to_h).to eq all_params
      end

      it "should create new MemberRelationship instance" do
        expect(described_class.new(all_params)).to be_a AcaEntities::BenefitMarkets::MemberRelationship
        expect(described_class.new(all_params).to_h).to eq all_params
      end
    end
  end
end