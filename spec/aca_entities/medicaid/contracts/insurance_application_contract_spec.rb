# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/insurance_application_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::InsuranceApplicationContract, type: :model do

  # it 'should be a container-ready operation' do
  #   expect(subject.respond_to?(:call)).to be_truthy
  # end

  let(:required_params) do
    {
      insurance_applicants: [insurance_applicant],
      requesting_financial_assistance: true,
      requesting_medicaid: false,
      tax_return_access: true,
      ssf_primary_contact: ssf_primary_contact,
      ssf_signer: ssf_signer,
      application_creation: application_creation,
      application_submission: application_submission,
      application_identifications: [{ identification_id: "Exchange" }]
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

  let(:ssf_primary_contact) do
    { 
      role_reference: { ref: "a-person-id" },
      contact_preference: "Email"
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
      not_incarcerated_indicators: [{metadata: nil, value: true}],
      information_changes_indicator: false
    }
  end

  let(:signature) do
    {
      date_time: {date: DateTime.now.to_date}
    }
  end

  let(:role_reference) do
    { ref: "a-person-id" }
  end

  let(:application_creation) do
    {
      creation_id: {identification_id: '2163565'},
      creation_date: {date_time: DateTime.now}
    }
  end

  let(:application_submission) do
    {
      activity_id: {identification_id: '2163565'},
      activity_date: {date_time: DateTime.now},
    }
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

  let(:optional_params) do
    { coverage_renewal_year_quantity: 2 }
  end

let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end

    context 'with optional parameters only' do
      it { expect(subject.call(optional_params).error?(required_params.first[0])).to be_truthy }
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
    end

    context 'with all required and optional parameters' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end