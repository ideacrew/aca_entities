# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/verification_date'
require 'aca_entities/medicaid/atp/verification_status'
require 'aca_entities/medicaid/atp/verification_requesting_system'
require 'aca_entities/medicaid/atp/dhs_save_verification_supplement'
require 'aca_entities/medicaid/atp/verification_metadata'

RSpec.describe ::AcaEntities::Medicaid::Atp::VerificationMetadata,  dbclean: :around_each do

  let(:required_params) do
    {
      id: "vm123",
      verification_date: { date: Date.today },
      verification_requesting_system:
        {
          category_code: "Exchange"
        }
    }
  end

  let(:dhs_save_verification_supplement) do
    {
      step_id: "1",
      lawful_presence_verification_code: "Y",
      five_year_bar_verification_code: "Y",
      qualified_non_citizen_verification_code: "Y",
      us_citizenship_verification_code: "Y"
    }
  end

  let(:optional_params) do
    {
      id: "vm123",
      address_verification_code: "verificationCode",
      dhs_g845_verification_code: "verificationCode",
      dhs_save_verification_code: "verificationCode",
      ffe_verification_code: "verificationCode",
      verification_authority_name: "Name",
      verification_authority_alpha_code: "alphaCode",
      verification_id: "id123",
      dhs_save_verification_supplement: dhs_save_verification_supplement,
      verification_indicator: true,
      verification_inconsistency_indicator: false,
      verification_description_text: "Text",
      verification_inconsistency_text: "n/a",
      verification_category_codes: ["codes"],
      response_code: "responseCode",
      verification_status: { status_code: "statusCode" }
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect { described_class.new }.to raise_error(Dry::Struct::Error, /:category_code is missing in Hash input/)
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:verification_date is missing in Hash input/)
      end
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      it 'should initialize' do
        expect(described_class.new(required_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(required_params) }.not_to raise_error
      end
    end

    context 'with all required and optional parameters' do
      it 'should initialize' do
        expect(described_class.new(required_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(required_params) }.not_to raise_error
      end
    end
  end
end