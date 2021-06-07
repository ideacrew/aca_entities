# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::CountyZip do

  context "Given valid required parameters" do

    let(:contract)          { AcaEntities::BenefitMarkets::Locations::CountyZipContract.new }
    let(:required_params)   { { county_name: 'abc county', zip: '22222', state: 'dc' } }

    context "with all/required params" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new CountyZip instance" do
        expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::CountyZip
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end
  end
end