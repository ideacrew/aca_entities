# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/role_of_person_reference'
require 'aca_entities/medicaid/atp/signature_date'
require 'aca_entities/medicaid/atp/signature'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/activity_date'
require 'aca_entities/medicaid/atp/authorized_representative_reference'
require 'aca_entities/medicaid/atp/not_incarcerated_indicator'
require "aca_entities/medicaid/atp/ssf_signer_authorized_representative_association"
require 'aca_entities/medicaid/atp/ssf_attestation'
require 'aca_entities/medicaid/atp/ssf_signer'
# require 'aca_entities/medicaid/atp/application_identity'
require 'aca_entities/medicaid/atp/insurance_application_assister_association'
require 'aca_entities/medicaid/atp/chip_trafficking_victim_category_eligibility_basis'
require 'aca_entities/medicaid/atp/chip_eligibility'
require 'aca_entities/medicaid/atp/ssf_primary_contact'
require 'aca_entities/medicaid/atp/lawful_presence_status_eligibility'
require 'aca_entities/medicaid/atp/insurance_applicant_lawful_presence_status'
require 'aca_entities/medicaid/atp/application_creation'
require 'aca_entities/medicaid/atp/application_identification'
require 'aca_entities/medicaid/atp/application_submission'
require 'aca_entities/medicaid/atp/insurance_applicant'
require 'aca_entities/medicaid/atp/insurance_application'

RSpec.describe ::AcaEntities::Medicaid::Atp::InsuranceApplication, dbclean: :after_each do

  describe 'with valid arguments' do

    let(:input_params) do
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
        application_identifications: [application_identification],
        assister_association: assister_association
      }
    end

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

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:ref is missing in Hash input/)
    end
  end
end
