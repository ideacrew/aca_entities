# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/ssf_attestation'
require 'aca_entities/medicaid/atp/ssf_signer'
require 'aca_entities/medicaid/atp/application_identity'
require 'aca_entities/medicaid/atp/application_metadata'
require 'aca_entities/medicaid/atp/role_of_person_reference'
require 'aca_entities/medicaid/atp/ssf_primary_contact'
require 'aca_entities/medicaid/atp/lawful_presence_status_eligibility'
require 'aca_entities/medicaid/atp/insurance_applicant_lawful_presence_status'
require 'aca_entities/medicaid/atp/insurance_applicant'
require 'aca_entities/medicaid/atp/insurance_application'

RSpec.describe ::AcaEntities::Medicaid::Atp::InsuranceApplication, dbclean: :after_each do

  describe 'with valid arguments' do
    
    let(:input_params) do
      {
        application_metadata: application_metadata,
        insurance_applicants: [insurance_applicant],
        requesting_financial_assistance: false, 
        requesting_medicaid: false, 
        ssf_primary_contact: ssf_primary_contact,
        ssf_signer: ssf_signer,
        tax_return_access_indicator: false
      }
    end

  let(:application_metadata) do
    {
      application_ids: [{ identification_id: "an application id" }],
      application_signature_date: DateTime.now,
      creation_date: DateTime.now,
      submission_date: DateTime.now,
      identification_category_text: "ID CATEGORY TEXT",
      financial_assistance_indicator: false,
      medicaid_determination_indicator: false
    }
  end

    let(:insurance_applicant) do
      { 
        role_reference: { ref: "a-person-id" } 
      }
    end

    let(:ssf_primary_contact) do
      { 
        role_reference: { ref: "a-person-id" },
        contact_preference: "Email"
      }
    end

    let(:ssf_signer) { ssf_attestation }
    
    let(:ssf_attestation) do
      { non_perjury_indicator: true,
        not_incarcerated_indicator: true,
        information_changes_indicator: false
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
      expect { subject }.to raise_error(Dry::Struct::Error, /:application_ids is missing in Hash input/)
    end
  end
end
