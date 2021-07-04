# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::ServiceArea do

  context "Given valid required parameters" do

    let(:contract)                  { AcaEntities::BenefitMarkets::Locations::ServiceAreaContract.new }
    let(:issuer_profile_reference) do
      {
        hbx_id: '1234', fein: '123333333', hbx_carrier_id: '333333',
        name: 'Delta Dental', abbrev: 'DDPA'
      }
    end
    let(:required_params) do
      {
        active_year: 2020, issuer_provided_title: 'Title', issuer_provided_code: 'issuer_provided_code',
        issuer_hios_id: 'issuer_hios_id', issuer_profile_reference: issuer_profile_reference,
        county_zip_ids: [{}], covered_states: [{}]
      }
    end

    context "with all/required params" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new ServiceArea instance" do
        expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::ServiceArea
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end
  end
end