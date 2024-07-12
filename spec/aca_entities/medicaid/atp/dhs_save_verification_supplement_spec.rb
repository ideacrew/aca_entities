# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/dhs_save_verification_supplement'

RSpec.describe ::AcaEntities::Medicaid::Atp::DhsSaveVerificationSupplement,  dbclean: :around_each do

  let(:optional_params) do
    {
      step_id: "1",
      lawful_presence_verification_code: "Y",
      five_year_bar_verification_code: "Y",
      qualified_non_citizen_verification_code: "Y",
      us_citizenship_verification_code: "Y"
    }
  end

  let(:invalid_params) do
    {
      step_id: "1",
      lawful_presence_verification_code: "X",
      five_year_bar_verification_code: "X",
      qualified_non_citizen_verification_code: "X",
      us_citizenship_verification_code: "X"
    }
  end

  let(:all_params) { optional_params }

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should not list any errors' do
        expect { described_class.new }.not_to raise_error
      end
    end

    context 'with invalid verification code' do
      it 'should list error for every required parameter' do
        expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /:lawful_presence_verification_code violates constraints/)
      end
    end
  end

  context 'valid parameters' do
    context 'with all parameters' do
      it 'should initialize' do
        expect(described_class.new(all_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(all_params) }.not_to raise_error
      end
    end
  end
end