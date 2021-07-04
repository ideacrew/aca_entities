# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::PremiumTable do

  context "Given valid required parameters" do
    let(:contract)            { AcaEntities::BenefitMarkets::Products::PremiumTableContract.new }

    let(:effective_date)      { Date.today.next_month }
    let(:effective_period)    { effective_date..effective_date.next_year.prev_day }
    let(:rating_area_params)  { { county_zip_ids: [{}], exchange_provided_code: 'code', covered_states: [{}], active_year: 2020 } }
    let(:required_params)     { { effective_period: effective_period, premium_tuples: nil, rating_area: rating_area_params } }

    context "with required only" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new PremiumTable instance" do
        expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::PremiumTable
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end

    context "with all params" do
      let(:all_params) { required_params.merge({ premium_tuples: [{ age: 12, cost: 227.07 }] }) }

      it "contract validation should pass" do
        expect(contract.call(all_params).to_h).to eq all_params
      end

      it "should create new PremiumTable instance" do
        expect(described_class.new(all_params)).to be_a AcaEntities::BenefitMarkets::PremiumTable
        expect(described_class.new(all_params).to_h).to eq all_params
      end
    end
  end
end