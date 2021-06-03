# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::Products::ProductContract do

  let(:benefit_market_kind)           { :benefit_market_kind }
  let(:effective_date)                { Date.today.next_month }
  let(:effective_period)              { effective_date..(effective_date.next_year) }
  let(:application_period)            { effective_date..effective_date.next_year.prev_day }
  let(:hbx_id)                        { 'Hbx id'}
  let(:title)                         { 'Title' }
  let(:description)                   { 'Description' }
  let(:product_package_kinds)         { [:product_package_kinds] }
  let(:kind)                          { :health }
  let(:provider_directory_url)        { 'provider_directory_url' }
  let(:is_reference_plan_eligible)    { true }
  let(:deductible)                    { 'deductible' }
  let(:family_deductible)             { 'family_deductible' }
  let(:network_information)           { 'network_information'}
  let(:nationwide)                    { true }
  let(:dc_in_network)                 { false }
  let(:hsa_eligibility)               { true }

  let(:sbc_document) do
    {
      title: 'title', creator: 'creator', publisher: 'publisher', format: 'file_format',
      language: 'language', type: 'type', source: 'source'
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

  let(:product_reference) do
    {
      hios_id: '92479DC0020002', name: 'Access PPO', active_year: 2020, is_dental_only: false,
      metal_level: 'gold', product_kind: 'health', benefit_market_kind: 'aca_shop', ehb_percent: '0.0',
      issuer_profile_reference: issuer_profile_reference
    }
  end

  let(:premium_tables)   { [{ effective_period: effective_period }] }

  let(:missing_params) do
    {
      benefit_market_kind: benefit_market_kind, application_period: application_period, product_reference: product_reference,
      hbx_id: hbx_id, title: title, description: description, product_package_kinds: product_package_kinds,
      issuer_profile_reference: issuer_profile_reference, premium_ages: 19..60, provider_directory_url: provider_directory_url,
      is_reference_plan_eligible: is_reference_plan_eligible, deductible: deductible, family_deductible: family_deductible,
      issuer_assigned_id: 'issuer_assigned_id', service_area: service_area, network_information: network_information,
      nationwide: nationwide, dc_in_network: dc_in_network, sbc_document: sbc_document
    }
  end

  let(:invalid_params)      { missing_params.merge({ kind: kind, premium_tables: 'premium_tables' }) }
  let(:error_message1)      { { :premium_tables => ["is missing"], :kind => ["is missing"] } }
  let(:error_message2)      { { :premium_tables => ["must be an array"] } }

  context "Given invalid required parameters" do
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
    context "with all/required params" do
      let(:premium_tuples)   { { age: 12, cost: 227.07 } }
      let(:rating_area_params) {{ county_zip_ids: [{}], exchange_provided_code: 'code', covered_states: [{}], active_year: 2020 }}
      let(:premium_tables)   { [{ effective_period: effective_period, premium_tuples: [premium_tuples], rating_area: rating_area_params }] }
      let(:all_params)       { missing_params.merge({ kind: kind, premium_tables: premium_tables })}

      it "should pass validation" do
        expect(subject.call(all_params).success?).to be_truthy
        expect(subject.call(all_params).to_h).to eq all_params
      end
    end
  end
end