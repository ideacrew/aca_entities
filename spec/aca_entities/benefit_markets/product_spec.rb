# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::Product do

  context "Given valid required parameters" do

    let(:contract)           { AcaEntities::BenefitMarkets::Products::ProductContract.new }

    let(:premium_tuples)     { { age: 12, cost: 227.07 } }
    let(:effective_period)   { effective_date..effective_date.next_year.prev_day }
    let(:rating_area_params) {{ county_zip_ids: [{}], exchange_provided_code: 'code', covered_states: [{}], active_year: 2020 }}
    let(:premium_tables)   { [{ effective_period: effective_period, premium_tuples: [premium_tuples], rating_area: rating_area_params }] }

    let(:effective_date)     { Date.today.next_month }
    let(:application_period) { effective_date..effective_date.next_year.prev_day }

    let(:premium_ages)       { 16..40 }

    let(:sbc_document) do
      {
        title: 'title', creator: 'creator', publisher: 'publisher', format: 'file_format', tags: [{}], description: nil, date: nil,
        language: 'language', type: 'type', source: 'source', subject: 'subject', identifier: 'identifier', contributor: nil,
        relation: nil, coverage: nil, rights: nil, size: nil
      }
    end

    let(:product_reference) do
      {
        hios_id: '92479DC0020002', name: 'Access PPO', active_year: 2020, is_dental_only: false,
        metal_level: 'gold', product_kind: 'health', benefit_market_kind: 'aca_shop', ehb_percent: '0.0',
        issuer_profile_reference: issuer_profile_reference
      }
    end

    let(:issuer_profile_reference) do
      {
        hbx_id: '1234', fein: '123333333', hbx_carrier_id: '333333',
        name: 'Delta Dental', abbrev: 'DDPA'
      }
    end

    let(:service_area) do
      {
        active_year: 2020, issuer_hios_id: 'hios_id', issuer_provided_title: 'Issuer Provided Title',
        issuer_provided_code: 'Issuer Provided code', county_zip_ids: [{}], covered_states: ['DC'],
        issuer_profile_reference: issuer_profile_reference
      }
    end

    let(:required_params) do
      {
        product_reference: product_reference, service_area: service_area, issuer_profile_reference: issuer_profile_reference,
        benefit_market_kind: :benefit_market_kind, application_period: application_period, kind: :kind, hbx_id: 'hbx_id', title: 'title',
        product_package_kinds: [:product_package_kinds], provider_directory_url: 'provider_directory_url', renewal_product_reference: nil,
        premium_ages: premium_ages, is_reference_plan_eligible: true, deductible: 'deductible', family_deductible: 'family_deductible',
        issuer_assigned_id: 'issuer_assigned_id', network_information: 'network_information', nationwide: true,
        dc_in_network: false, sbc_document: sbc_document, premium_tables: premium_tables, description: nil
      }
    end

    context "with required only" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new Product instance" do
        expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::Product
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end

    context "with all params" do
      let(:all_params) {required_params.merge({ description: 'description' })}

      it "contract validation should pass" do
        expect(contract.call(all_params).to_h).to eq all_params
      end

      it "should create new Product instance" do
        expect(described_class.new(all_params)).to be_a AcaEntities::BenefitMarkets::Product
        expect(described_class.new(all_params).to_h).to eq all_params
      end
    end
  end
end