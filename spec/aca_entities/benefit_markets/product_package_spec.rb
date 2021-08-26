# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::ProductPackage do

  context "Given valid required parameters" do

    let(:contract)                  { AcaEntities::BenefitMarkets::Products::ProductPackageContract.new }

    let(:effective_date)            { Date.today.next_month }
    let(:application_period)        { effective_date..effective_date.next_year.prev_day }

    let(:premium_ages)              { 16..40 }

    let(:pricing_units)             { [{ name: 'name', display_name: 'Employee Only', order: 1 }] }
    let(:member_relationships)      do
      [{ relationship_name: :employee, relationship_kinds: [{}], age_threshold: 18, age_comparison: :==, disability_qualifier: true }]
    end
    let(:pricing_model) do
      {
        name: 'name', price_calculator_kind: 'price_calculator_kind', pricing_units: pricing_units,
        product_multiplicities: [:product_multiplicities], member_relationships: member_relationships
      }
    end

    let(:contribution_unit) do
      {
        name: "Employee",
        display_name: "Employee Only",
        order: 1,
        member_relationship_maps: [relationship_name: :employee, operator: :==, count: 1]
      }
    end

    let(:contribution_model) do
      {
        title: 'title', sponsor_contribution_kind: 'sponsor_contribution_kind', contribution_calculator_kind: 'contribution_calculator_kind',
        many_simultaneous_contribution_units: true, product_multiplicities: [:product_multiplicities1, :product_multiplicities2],
        member_relationships: member_relationships, contribution_units: [contribution_unit], key: :key
      }
    end

    let(:sbc_document) do
      {
        title: 'title', creator: 'creator', publisher: 'publisher', format: 'file_format', tags: [{}], description: nil, date: nil,
        language: 'language', type: 'type', source: 'source', subject: 'subject', identifier: 'identifier', contributor: nil,
        relation: nil, coverage: nil, rights: nil, size: nil
      }
    end

    let(:premium_tuples)   { { age: 12, cost: 227.07 } }
    let(:effective_period)    { effective_date..effective_date.next_year.prev_day }
    let(:rating_area_params) {{ county_zip_ids: [{}], exchange_provided_code: 'code', covered_states: [{}], active_year: 2020 }}
    let(:premium_tables)   { [{ effective_period: effective_period, premium_tuples: [premium_tuples], rating_area: rating_area_params }] }
    let(:issuer_profile_reference) do
      {
        hbx_id: '1234', fein: '123333333', hbx_carrier_id: '333333',
        name: 'Delta Dental', abbrev: 'DDPA'
      }
    end

    let(:product_reference) do
      {
        hios_id: '92479DC0020002', name: 'Access PPO', active_year: 2020, is_dental_only: false,
        metal_level: 'gold', product_kind: 'health', benefit_market_kind: 'aca_shop', ehb_percent: '0.0',
        issuer_profile_reference: issuer_profile_reference
      }
    end

    let(:service_area) do
      {
        active_year: 2020, issuer_hios_id: 'hios_id', issuer_provided_title: 'Issuer Provided Title',
        issuer_provided_code: 'Issuer Provided code', county_zip_ids: [{}], covered_states: ['DC'],
        issuer_profile_reference: issuer_profile_reference
      }
    end

    let(:product) do
      {
        product_reference: product_reference, service_area: service_area, issuer_profile_reference: issuer_profile_reference,
        hios_id: '9879', hios_base_id: '34985', metal_level_kind: :silver, sbc_document: sbc_document, premium_tables: premium_tables,
        ehb: 0.9, is_standard_plan: true, hsa_eligibility: true, csr_variant_id: '01', health_plan_kind: :health_plan_kind,
        benefit_market_kind: :benefit_market_kind, application_period: application_period, kind: :health,
        hbx_id: 'hbx_id', title: 'title', description: 'description', product_package_kinds: [:product_package_kinds],
        premium_ages: 19..60, provider_directory_url: 'provider_directory_url', nationwide: true, dc_in_network: false,
        is_reference_plan_eligible: true, deductible: '123', family_deductible: '345', rx_formulary_url: 'rx_formulary_url',
        issuer_assigned_id: 'issuer_assigned_id', network_information: 'network_information', renewal_product_reference: nil
      }
    end

    let(:required_params) do
      {
        application_period: application_period, benefit_kind: :benefit_kind, product_kind: :product_kind, package_kind: :package_kind,
        title: 'Title', products: [product], contribution_model: contribution_model, contribution_models: [contribution_model],
        assigned_contribution_model: contribution_model, description: nil, pricing_model: pricing_model
      }
    end

    context "with required only" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new ProductPackage instance" do
        expect(described_class.new(required_params)).to be_a AcaEntities::BenefitMarkets::ProductPackage
        # expect(described_class.new(required_params).to_h).to eq required_params
      end
    end

    context "with all params" do
      let(:all_params) {required_params.merge({ description: 'description', assigned_contribution_model: contribution_model })}

      it "contract validation should pass" do
        expect(contract.call(all_params).to_h).to eq all_params
      end

      it "should create new ProductPackage instance" do
        expect(described_class.new(all_params)).to be_a AcaEntities::BenefitMarkets::ProductPackage
        # expect(described_class.new(all_params).to_h).to eq all_params
      end
    end
  end
end