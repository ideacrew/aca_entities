# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe ::AcaEntities::InsurancePolicies::AcaIndividuals::AptcCsrTaxHousehold, dbclean: :after_each do
  include_context('insurance_policies_context')

  let(:moment) { DateTime.now }

  let(:currency) do
    {
      cents: 98_700.0,
      currency_iso: "USD"
    }
  end

  let!(:person_name) do
    {
      first_name: 'first name',
      middle_name: 'middle name',
      last_name: 'last name'
    }
  end

  let!(:person_health) do
    {
      is_tobacco_user: 'unknown',
      is_physically_disabled: false
    }
  end

  let!(:demographics) do
    {
      ssn: "123456789",
      no_ssn: false,
      gender: 'male',
      dob: Date.today,
      is_incarcerated: false
    }
  end

  let!(:person_reference) do
    {
      hbx_id: '1234',
      first_name: 'first name',
      middle_name: 'middle name',
      last_name: 'last name',
      dob: Date.today,
      gender: 'male',
      ssn: nil
    }
  end

  let(:person_addresses) do
    [
      {
        kind: "home",
        address_1: "S Street NW",
        address_2: "",
        address_3: "",
        city: "Washington",
        county: "",
        state: "ME",
        location_state_code: nil,
        full_text: nil,
        zip: "20009",
        country_name: ""
      }
    ]
  end

  let!(:person) do
    {
      hbx_id: '1001',
      is_active: true,
      is_disabled: false,
      no_dc_address: nil,
      no_dc_address_reason: nil,
      is_homeless: nil,
      is_temporarily_out_of_state: nil,
      age_off_excluded: nil,
      is_applying_for_assistance: nil,
      person_name: person_name,
      person_health: person_health,
      demographics: demographics,
      person_relationships: [],
      addresses: person_addresses,
      phones: phones,
      emails: emails
    }
  end

  let(:covered_individual) do
    {
      coverage_start_on: january_1,
      coverage_end_on: december_31,
      person: person,
      filer_status: "tax_filer",
      relation_with_primary: "self"
    }
  end

  let(:tax_household_member) do
    {
      family_member_reference: { family_member_hbx_id: "12345",
                                 first_name: "test", last_name: "payload", relation_with_primary: "self" },
      tax_filer_status: "tax_filer"
    }
  end

  let(:coverage_information) do
    {
      tax_credit: currency,
      total_premium: currency,
      slcsp_benchmark_premium: currency
    }
  end

  let(:months_of_year) do
    {
      month: "January",
      coverage_information: coverage_information
    }
  end

  let(:aptc_csr_tax_household) do
    {
      hbx_assigned_id: '6232341',
      primary_tax_filer_hbx_id: '12345',
      tax_household_members: [tax_household_member],
      covered_individuals: [covered_individual],
      months_of_year: [months_of_year],
      annual_premiums: coverage_information
    }
  end

  let(:input_params) do
    aptc_csr_tax_household
  end

  let(:aptc_csr_tax_household_params) do
    AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::AptcCsrTaxHouseholdContract.new.call(input_params)
  end

  describe 'with valid arguments' do
    it 'validates input params with contract' do
      expect(aptc_csr_tax_household_params.success?).to be_truthy
    end

    it 'should initialize' do
      expect(described_class.new(aptc_csr_tax_household_params.to_h)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(aptc_csr_tax_household_params.to_h) }.not_to raise_error
    end
  end

  describe '#tax_household_same_as?' do
    let(:person2_hbx_id) { '1001' }

    let!(:person2_name) do
      {
        first_name: 'first name2',
        middle_name: 'middle2 name',
        last_name: 'last2 name'
      }
    end

    let(:person2_health) { { is_tobacco_user: 'testing', is_physically_disabled: true } }

    let(:person2_demographics) do
      { ssn: '123454789', no_ssn: true, gender: 'female', dob: Date.today - 10, is_incarcerated: true }
    end

    let(:person2_addresses) do
      [
        {
          kind: "home",
          address_1: "100 Street NW",
          address_2: "",
          address_3: "",
          city: "Washington",
          county: "",
          state: "DC",
          location_state_code: nil,
          full_text: nil,
          zip: "20609",
          country_name: ""
        }
      ]
    end

    let(:phones2) { [{ kind: 'mobile', primary: true, area_code: '108', number: '111111', start_on: moment }] }

    let(:emails2) { [{ kind: 'home', address: "testing.gg@example.com" }] }

    let(:person2) do
      {
        hbx_id: person2_hbx_id,
        is_active: false,
        is_disabled: true,
        no_dc_address: nil,
        no_dc_address_reason: nil,
        is_homeless: true,
        is_temporarily_out_of_state: true,
        age_off_excluded: nil,
        is_applying_for_assistance: true,
        person_name: person2_name,
        person_health: person2_health,
        demographics: person2_demographics,
        person_relationships: [],
        addresses: person2_addresses,
        phones: phones2,
        emails: emails2
      }
    end

    let(:coverage_start_on2) { january_1 }
    let(:coverage_end_on2) { december_31 }
    let(:filter_status2) { 'separate' }

    let(:covered_individual2) do
      {
        coverage_start_on: coverage_start_on2,
        coverage_end_on: coverage_end_on2,
        person: person2,
        filer_status: filter_status2,
        relation_with_primary: "spouse"
      }
    end

    let(:tax_household_member2) do
      {
        family_member_reference: { family_member_hbx_id: "7235723",
                                   first_name: "test", last_name: "last", relation_with_primary: "child" },
        tax_filer_status: "separate"
      }
    end

    let(:coverage_information2) do
      {
        tax_credit: currency,
        total_premium: currency,
        slcsp_benchmark_premium: currency
      }
    end

    let(:annual_currency) { { cents: 100_700.0, currency_iso: "USD" } }

    let(:coverage_information3) do
      {
        tax_credit: annual_currency,
        total_premium: annual_currency,
        slcsp_benchmark_premium: annual_currency
      }
    end

    let(:month_name2) { "January" }
    let(:months_of_year2) { { month: month_name2, coverage_information: coverage_information2 } }

    let(:primary_tax_filer_hbx_id2) { '12345' }

    let(:aptc_csr_tax_household2) do
      {
        hbx_assigned_id: '6232341',
        primary_tax_filer_hbx_id: primary_tax_filer_hbx_id2,
        tax_household_members: [tax_household_member2],
        covered_individuals: [covered_individual2],
        months_of_year: [months_of_year2],
        annual_premiums: coverage_information3
      }
    end

    let(:tax_household1_params) do
      AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::AptcCsrTaxHouseholdContract.new.call(aptc_csr_tax_household).to_h
    end

    let(:tax_household1) do
      ::AcaEntities::InsurancePolicies::AcaIndividuals::AptcCsrTaxHousehold.new(tax_household1_params)
    end

    let(:tax_household2_params) do
      AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::AptcCsrTaxHouseholdContract.new.call(aptc_csr_tax_household2).to_h
    end

    let(:tax_household2) do
      ::AcaEntities::InsurancePolicies::AcaIndividuals::AptcCsrTaxHousehold.new(tax_household2_params)
    end

    context 'exactly same params' do
      let(:annual_currency) { { cents: 98_700.0, currency_iso: "USD" } }

      it 'returns true' do
        expect(tax_household1.tax_household_same_as?(tax_household2)).to eq(true)
      end
    end

    context 'annual premiums are different' do

      it 'returns true' do
        expect(tax_household1.tax_household_same_as?(tax_household2)).to eq(false)
      end
    end

    context 'primary_tax_filer_hbx_id is different' do
      let(:primary_tax_filer_hbx_id2) { '22222' }

      it 'returns false' do
        expect(tax_household1.tax_household_same_as?(tax_household2)).to eq(false)
      end
    end

    context 'covered_individuals information is different' do
      let(:person2_hbx_id) { '82367' }
      let(:coverage_start_on2) { Date.new(moment.year, 2, 1) }
      let(:coverage_end_on2) { june_30 }

      it 'returns false' do
        expect(tax_household1.tax_household_same_as?(tax_household2)).to eq(false)
      end
    end

    context 'months_of_year information is different' do
      let(:currency2) { { cents: 133_700.0, currency_iso: "USD" } }
      let(:month_name2) { 'February' }

      it 'returns false' do
        expect(tax_household1.tax_household_same_as?(tax_household2)).to eq(false)
      end
    end

    context 'person hbx_id is different' do
      let(:person2_hbx_id) { '22001' }

      it 'returns false' do
        expect(tax_household1.tax_household_same_as?(tax_household2)).to eq(false)
      end
    end

    context 'months_of_year information is different' do
      let(:currency2) { { cents: 133_700.0, currency_iso: "USD" } }
      let(:month_name2) { 'February' }

      it 'returns false' do
        expect(tax_household1.tax_household_same_as?(tax_household2)).to eq(false)
      end
    end
  end
end
