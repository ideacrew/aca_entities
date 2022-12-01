# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Products::ProductReference, dbclean: :after_each do

  let(:issuer_profile_reference) do
    {
      hbx_id: '1234',
      fein: '123333333',
      hbx_carrier_id: '333333',
      name: 'Delta Dental',
      abbrev: 'DDPA'
    }
  end

  let(:family_rated_premiums) do
    {
      exchange_provided_code: 'R-ME002',
      primary_enrollee: 40.5,
      primary_enrollee_one_dependent: 80.5,
      primary_enrollee_many_dependent: 159.0
    }
  end

  let(:input_params) do
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
      pediatric_dental_ehb: 0.9449,
      family_rated_premiums: family_rated_premiums
    }
  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(input_params.reject do |k, _v|
                              k == :issuer_profile_reference
                            end)
      end.to raise_error(Dry::Struct::Error, /:issuer_profile_reference is missing/)
    end
  end
end
