# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::Products::ProductPackageContract do

  let(:effective_date)                { Date.today.next_month }
  let(:application_period)            { effective_date..effective_date.next_year }
  let(:benefit_kind)                  { :benefit_kind }
  let(:product_kind)                  { :product_kind}
  let(:package_kind)                  { :package_kind }
  let(:title)                         { 'Title' }
  let(:description)                   { 'Description' }

  let(:pricing_units)                 { [{ name: 'name', display_name: 'Employee Only', order: 1 }] }
  let(:member_relationships)          do
    [{ relationship_name: :employee, relationship_kinds: ['self'], age_threshold: 18, age_comparison: :==, disability_qualifier: true }]
  end
  let(:pricing_model) do
    {
      name: 'name', price_calculator_kind: 'price_calculator_kind', pricing_units: pricing_units,
      product_multiplicities: [:product_multiplicities], member_relationships: member_relationships
    }
  end

  let(:member_relationship_map)       do
    AcaEntities::BenefitMarkets::MemberRelationshipMap.new(relationship_name: :Employee, count: 1, operator: :>=).to_h
  end
  let(:member_relationship_maps)      { [member_relationship_map] }
  let(:contribution_unit) do
    AcaEntities::BenefitMarkets::ContributionUnit.new(
      name: "Employee",
      display_name: "Employee Only",
      order: 1,
      member_relationship_maps: member_relationship_maps
    )
  end

  let(:contribution_units)            { [contribution_unit.to_h] }

  let(:contribution_model) do
    {
      title: 'title', key: :key, sponsor_contribution_kind: 'sponsor_contribution_kind', contribution_calculator_kind: 'contribution_calculator_kind',
      many_simultaneous_contribution_units: true, product_multiplicities: [:product_multiplicities1, :product_multiplicities2],
      member_relationships: member_relationships, contribution_units: contribution_units
    }
  end

  let(:missing_params)   do
    { application_period: application_period, benefit_kind: benefit_kind, product_kind: product_kind, package_kind: package_kind, title: title }
  end

  let(:contribution_models)           { [contribution_model] }
  let(:assigned_contribution_model)   { contribution_model  }
  let(:sbc_document) do
    {
      title: 'title', creator: 'creator', publisher: 'publisher', format: 'file_format',
      language: 'language', type: 'type', source: 'source'
    }
  end

  let(:rating_area_params) {{ county_zip_ids: [{}], exchange_provided_code: 'code', covered_states: [{}], active_year: 2020 }}
  let(:premium_tables)   { [{ effective_period: effective_period, premium_tuples: [premium_tuples], rating_area: rating_area_params }] }
  let(:premium_tuples)   { { age: 12, cost: 227.07 } }
  let(:effective_period) { effective_date..effective_date.next_year.prev_day }

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
      issuer_assigned_id: 'issuer_assigned_id', network_information: 'network_information'
    }
  end

  let(:products)        { [product] }

  context "Given invalid required parameters" do
    let(:invalid_params)   do
      missing_params.merge({ pricing_model: {}, contribution_model: contribution_model, contribution_models: contribution_models,
                             assigned_contribution_model: assigned_contribution_model })
    end
    let(:error_message1)   do
      { :assigned_contribution_model => ["is missing"], :products => ["is missing"], :pricing_model => ["is missing"],
        :contribution_model => ["is missing"], :contribution_models => ["is missing"] }
    end
    let(:error_message2)   { { :pricing_model => ["must be filled"], :products => ["is missing"] } }

    context "sending with missing parameters should fail validation with errors" do
      it { expect(subject.call(missing_params).failure?).to be_truthy }
      it { expect(subject.call(missing_params).errors.to_h).to eq error_message1 }
    end

    context "sending with invalid parameters should fail validation with errors" do
      it { expect(subject.call(invalid_params).failure?).to be_truthy }
      it { expect(subject.call(invalid_params).errors.to_h).to eq error_message2 }
    end
  end

  context "Given valid required parameters" do
    let(:required_params) do
      missing_params.merge({ contribution_model: contribution_model, contribution_models: contribution_models,
                             pricing_model: pricing_model, products: products, assigned_contribution_model: assigned_contribution_model })
    end

    context "with a required only" do
      it "should pass validation" do
        expect(subject.call(required_params).success?).to be_truthy
        expect(subject.call(required_params).to_h).to eq required_params
      end
    end

    context "with all params" do
      let(:all_params) { required_params.merge({ description: description, assigned_contribution_model: assigned_contribution_model })}

      it "should pass validation" do
        expect(subject.call(all_params).success?).to be_truthy
        expect(subject.call(all_params).to_h).to eq all_params
      end
    end
  end
end
