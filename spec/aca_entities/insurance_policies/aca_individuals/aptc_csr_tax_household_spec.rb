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

  let!(:person_demographics) do
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
      person_demographics: person_demographics,
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
end
