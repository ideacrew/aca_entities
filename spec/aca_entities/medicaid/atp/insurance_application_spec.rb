# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/activity_date'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/status_valid_date_range'
require 'aca_entities/medicaid/atp/eligibility_basis_determination'
require 'aca_entities/medicaid/atp/eligibility_basis'
require 'aca_entities/medicaid/atp/eligibility_date_range'
require 'aca_entities/medicaid/atp/eligibility_determination'
require 'aca_entities/medicaid/atp/income_compatibility_determination'
require 'aca_entities/medicaid/atp/income_compatibility'
require 'aca_entities/medicaid/atp/medicaid_magi_income_eligibility_basis'
require 'aca_entities/medicaid/atp/medicaid_magi_eligibility'
require 'aca_entities/medicaid/atp/role_of_person_reference'
require 'aca_entities/medicaid/atp/association_begin_date'
require 'aca_entities/medicaid/atp/association_end_date'
require 'aca_entities/medicaid/atp/signature_date'
require 'aca_entities/medicaid/atp/signature'
require 'aca_entities/medicaid/atp/authorized_representative_reference'
require 'aca_entities/medicaid/atp/not_incarcerated_indicator'
require "aca_entities/medicaid/atp/ssf_signer_authorized_representative_association"
require 'aca_entities/medicaid/atp/ssf_attestation'
require 'aca_entities/medicaid/atp/ssf_signer'
require 'aca_entities/medicaid/atp/document_person_identification'
require 'aca_entities/medicaid/atp/document_expiration_date'
require 'aca_entities/medicaid/atp/document_number'
require 'aca_entities/medicaid/atp/immigration_document'
# require 'aca_entities/medicaid/atp/application_identity'
require 'aca_entities/medicaid/atp/insurance_application_assister_reference'
require 'aca_entities/medicaid/atp/insurance_application_assister_association'
require 'aca_entities/medicaid/atp/chip_trafficking_victim_category_eligibility_basis'
require 'aca_entities/medicaid/atp/chip_eligibility'
require 'aca_entities/medicaid/atp/ssf_primary_contact'
require 'aca_entities/medicaid/atp/lawful_presence_status_eligibility'
require 'aca_entities/medicaid/atp/insurance_applicant_lawful_presence_status'
require 'aca_entities/medicaid/atp/application_creation'
require 'aca_entities/medicaid/atp/application_identification'
require 'aca_entities/medicaid/atp/application_submission'
require 'aca_entities/medicaid/atp/incarceration_date'
require 'aca_entities/medicaid/atp/incarceration'
require 'aca_entities/medicaid/atp/referral_activity_status'
require 'aca_entities/medicaid/atp/referral_activity_sender_reference'
require 'aca_entities/medicaid/atp/referral_activity_receiver_reference'
require 'aca_entities/medicaid/atp/referral_activity'
require 'aca_entities/medicaid/atp/insurance_applicant'
require 'aca_entities/medicaid/atp/insurance_application'

RSpec.describe ::AcaEntities::Medicaid::Atp::InsuranceApplication do

  let(:required_params) do
    {
      insurance_applicants: [insurance_applicant],
      requesting_financial_assistance: true,
      coverage_renewal_year_quantity: 2,
      requesting_medicaid: false,
      tax_return_access: true,
      ssf_primary_contact: { contact_preference: 'Email', role_reference: role_reference },
      ssf_signer: ssf_signer,
      application_creation: application_creation,
      application_submission: application_submission,
      application_identifications: [application_identification]
    }
  end

  let(:optional_params) { { assister_association: assister_association } }

  let(:all_params) { required_params.merge(optional_params) }

  let(:insurance_applicant) do
    {
      role_reference: role_reference,
      esi_eligible_indicator: false,
      age_left_foster_care: 14,
      foster_care_state: "n/a",
      had_medicaid_during_foster_care_indicator: false,
      blindness_or_disability_indicator: false,
      lawful_presence_status: lawful_presence_status,
      long_term_care_indicator: false,
      chip_eligibilities: [trafficking_victim_category_eligibility_basis],
      temporarily_lives_outside_application_state_indicator: false,
      foster_care_indicator: false,
      fixed_address_indicator: true
    }
  end

  let(:ssf_signer) do
    {
      role_reference: role_reference,
      signature: signature,
      ssf_attestation: ssf_attestation
    }
  end

  let(:ssf_attestation) do
    {
      non_perjury_indicator: true,
      not_incarcerated_indicators: [{ metadata: nil, value: true }],
      information_changes_indicator: false
    }
  end

  let(:signature) do
    {
      signature_date: { date: DateTime.now.to_date }
    }
  end

  let(:role_reference) do
    { ref: "a-person-id" }
  end

  let(:lawful_presence_status) do
    {
      arrived_before_1996_indicator: false,
      lawful_presence_status_eligibility: {
        eligibility_indicator: true,
        eligibility_basis_status_code: "Complete"
      }
    }
  end

  let(:trafficking_victim_category_eligibility_basis) do
    {
      status_indicator: false
    }
  end

  let(:application_creation) do
    {
      creation_id: { identification_id: '2163565' },
      creation_date: { date_time: DateTime.now }
    }
  end

  let(:application_submission) do
    {
      activity_id: { identification_id: '2163565' },
      activity_date: { date_time: DateTime.now }
    }
  end

  let(:application_identification) do
    {
      identification_id: "Exchange"
    }
  end

  let(:assister_association) do
    {
      begin_date: { date_time: DateTime.now },
      assister_reference: { ref: "a-assister-id" }
    }
  end

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect { described_class.new }.to raise_error(Dry::Struct::Error, /:ref is missing in Hash input/)
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:insurance_applicants is missing in Hash input/)
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
