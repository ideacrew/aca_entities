# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Determinations::ProductEligibilityDetermination, dbclean: :after_each do

  let!(:currency) do
    {
      cents: 0.0,
      currency_iso: "USD"
    }
  end

  let(:input_params) do
    {
      is_ia_eligible: true,
      is_medicaid_chip_eligible: false,
      is_totally_ineligible: false,
      is_uqhp_eligible: false,
      is_non_magi_medicaid_eligible: false,
      magi_as_percentage_of_fpl: 0.0,
      magi_medicaid_type: nil,
      magi_medicaid_category: nil,
      magi_medicaid_monthly_household_income: currency,
      magi_medicaid_monthly_income_limit: currency,
      medicaid_household_size: nil,
      is_without_assistance: false
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
    # #Strict validation is removed for mcr migration, this will not raise error. Enable this spec when validation is in place.
    # it 'should raise error' do
    #   expect do
    #     described_class.new(input_params.reject do |k, _v|
    #                           k == :magi_medicaid_monthly_income_limit
    #                         end)
    #   end.to raise_error(Dry::Struct::Error, /:magi_medicaid_monthly_income_limit is missing/)
    # end
  end
end
