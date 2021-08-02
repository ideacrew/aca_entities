# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/activity_date'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/referral_activity_sender_reference'
require 'aca_entities/medicaid/atp/referral_activity_receiver_reference'
require 'aca_entities/medicaid/atp/referral_activity_status'
require 'aca_entities/medicaid/atp/referral_activity'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/status_valid_date_range'
require 'aca_entities/medicaid/atp/eligibility_basis_determination'
require 'aca_entities/medicaid/atp/eligibility_basis'
require 'aca_entities/medicaid/atp/income_compatibility_determination'
require 'aca_entities/medicaid/atp/income_compatibility'
require 'aca_entities/medicaid/atp/medicaid_magi_income_eligibility_basis'
require 'aca_entities/medicaid/atp/eligibility_determination'
require 'aca_entities/medicaid/atp/eligibility_date_range'
require 'aca_entities/medicaid/atp/emergency_medicaid_income_eligibility_basis'
require 'aca_entities/medicaid/atp/role_of_person_reference'
require 'aca_entities/medicaid/atp/chip_trafficking_victim_category_eligibility_basis'
require 'aca_entities/medicaid/atp/chip_eligibility'
require 'aca_entities/medicaid/atp/document_expiration_date'
require 'aca_entities/medicaid/atp/document_number'
require 'aca_entities/medicaid/atp/document_person_identification'
require 'aca_entities/medicaid/atp/incarceration_date'
require 'aca_entities/medicaid/atp/incarceration'
require 'aca_entities/medicaid/atp/immigration_document'
require 'aca_entities/medicaid/atp/lawful_presence_status_eligibility'
require 'aca_entities/medicaid/atp/medicaid_magi_eligibility'
require 'aca_entities/medicaid/atp/insurance_applicant_lawful_presence_status'
require 'aca_entities/medicaid/atp/insurance_applicant'

RSpec.describe ::AcaEntities::Medicaid::Atp::InsuranceApplicant, dbclean: :around_each do

  # describe 'with valid arguments' do
  let(:required_params) do
    { role_reference: { ref: "a-person-id" },
      fixed_address_indicator: true }
  end

  let(:optional_params) do
    { esi_eligible_indicator: false,
      non_esi_coverage_indicators: [false],
      age_left_foster_care: 14,
      foster_care_state: "n/a",
      blindness_or_disability_indicator: false,
      had_medicaid_during_foster_care_indicator: false,
      lawful_presence_status:
        { arrived_before_1996_indicator: false,
          lawful_presence_status_eligibility: { eligibility_indicator: false } },
      long_term_care_indicator: false,
      temporarily_lives_outside_application_state_indicator: false,
      foster_care_indicator: false,
      chip_eligibilities: [{ status_indicator: false }] }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect { described_class.new }.to raise_error(Dry::Struct::Error, /:ref is missing in Hash input/)
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:role_reference is missing in Hash input/)
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