# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::BenchmarkProducts::BenchmarkProduct do

  describe 'with valid arguments' do
    let(:issuer_profile_reference) do
      {
        hbx_id: '1234',
        fein: '123333333',
        hbx_carrier_id: '333333',
        name: 'Delta Dental',
        abbrev: 'DDPA'
      }
    end

    let(:health_product_reference) do
      {
        hios_id: '92479DC0020002',
        name: 'Access PPO',
        active_year: Date.today.year,
        is_dental_only: false,
        metal_level: 'gold',
        benefit_market_kind: 'aca_individual',
        product_kind: 'health',
        ehb_percent: '0.0',
        issuer_profile_reference: issuer_profile_reference,
        covers_pediatric_dental_costs: true,
        rating_method: 'Age-Based Rates',
        pediatric_dental_ehb: nil
      }
    end

    let(:dental_product_reference) do
      {
        hios_id: '92479DC0020011',
        name: 'Access PPO',
        active_year: Date.today.year,
        is_dental_only: true,
        metal_level: 'dental',
        benefit_market_kind: 'aca_individual',
        product_kind: 'dental',
        ehb_percent: '0.0',
        issuer_profile_reference: issuer_profile_reference,
        covers_pediatric_dental_costs: false,
        rating_method: 'Age-Based Rates',
        pediatric_dental_ehb: BigDecimal('1.0')
      }
    end

    let(:primary_rating_address) do
      { has_fixed_address: true,
        kind: 'home',
        address_1: '1234 street',
        address_3: 'person',
        city: 'test',
        county: 'County',
        state: 'DC',
        zip: '12345',
        country_name: 'USA',
        validation_status: 'ValidMatch',
        start_on: '2021/1/12',
        end_on: nil,
        lives_outside_state_temporarily: false,
        geocode: "00000" }
    end

    let(:member) do
      { applicant_reference: { first_name: 'first_name',
                               last_name: 'last_name',
                               dob: Date.today,
                               person_hbx_id: '109990' },
        relationship_with_primary: 'self',
        age_on_effective_date: 20 }
    end

    let(:household) do
      { household_hbx_id: '12345',
        type_of_household: 'adult_only',
        household_ehb_premium: BigDecimal('100.75'),
        household_health_ehb_premium: BigDecimal('100.75'),
        health_product_reference: health_product_reference,
        household_dental_ehb_premium: BigDecimal('50.25'),
        dental_product_reference: dental_product_reference,
        members: [member] }
    end

    let(:input_params) do
      { effective_date: Date.today,
        primary_rating_address: primary_rating_address,
        exchange_provided_code: 'IC01',
        household_group_ehb_premium: BigDecimal('100.75'),
        households: [household] }
    end

    before do
      validated_params = AcaEntities::MagiMedicaid::Contracts::BenchmarkProducts::BenchmarkProductContract.new.call(input_params)
      @result = if validated_params.failure?
                  validated_params
                else
                  described_class.new(validated_params.to_h)
                end
    end

    it 'should return benchmark_product entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of benchmark product' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end

    it 'should match all the input keys of primary_rating_address' do
      expect(@result.to_h[:primary_rating_address].keys).to eq(primary_rating_address.keys)
    end

    it 'should match all the input keys of household' do
      expect(@result.to_h[:households].first.keys).to eq(household.keys)
    end

    it 'should match all the input keys of health_product_reference' do
      expect(@result.to_h[:households].first[:health_product_reference].keys).to eq(health_product_reference.keys)
    end

    it 'should match all the input keys of dental_product_reference' do
      expect(@result.to_h[:households].first[:dental_product_reference].keys).to eq(dental_product_reference.keys)
    end

    it 'should match all the input keys of member' do
      expect(@result.to_h[:households].first[:members].first.keys).to eq(member.keys)
    end

    it 'should match all the input keys of applicant_reference' do
      expect(@result.to_h[:households].first[:members].first[:applicant_reference].keys).to eq(member[:applicant_reference].keys)
    end
  end
end
