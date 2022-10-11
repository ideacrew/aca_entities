# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::BenchmarkProducts::HouseholdContract,  dbclean: :after_each do
  subject { described_class.new.call(input_params) }

  describe '#call' do
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
        active_year: 2020,
        is_dental_only: false,
        metal_level: 'gold',
        product_kind: 'health',
        benefit_market_kind: 'aca_shop',
        ehb_percent: '0.0',
        issuer_profile_reference: issuer_profile_reference,
        covers_pediatric_dental_costs: true,
        rating_method: 'Age-Based Rates',
        pediatric_dental_ehb: nil
      }
    end

    let(:dental_product_reference) do
      {
        hios_id: '92479DC0020002',
        name: 'Access PPO',
        active_year: 2020,
        is_dental_only: false,
        metal_level: 'gold',
        product_kind: 'health',
        benefit_market_kind: 'aca_shop',
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

    context 'with valid input_params' do
      let(:input_params) do
        { household_hbx_id: '12345',
          type_of_household: 'adult_only',
          household_ehb_premium: BigDecimal('100.75'),
          household_health_ehb_premium: BigDecimal('100.75'),
          health_product_reference: health_product_reference,
          household_dental_ehb_premium: BigDecimal('50.25'),
          dental_product_reference: dental_product_reference,
          members: [member] }
      end

      it 'should return success moand' do
        expect(subject).to be_success
      end
    end

    context 'with invalid input_params' do
      let(:input_params) { {} }

      it 'should return failure moand with error keys' do
        expect(subject).to be_failure
        expect(subject.errors.to_h.keys).to eq([:household_hbx_id,
                                                :type_of_household,
                                                :household_ehb_premium,
                                                :household_health_ehb_premium,
                                                :health_product_reference,
                                                :members])
      end
    end
  end
end
