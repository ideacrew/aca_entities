# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/account_transfer_request_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::AccountTransferRequestContract, type: :model do

  let(:transfer_header) do
    {
      transfer_activity: transfer_activity
    }
  end

  let(:insurance_application) do
    {
      insurance_applicants: [insurance_applicant],
      requesting_financial_assistance: true,
      coverage_renewal_year_quantity: 2,
      requesting_medicaid: false,
      tax_return_access: true,
      ssf_primary_contact: {contact_preference: 'Email', role_reference: role_reference},
      ssf_signer: ssf_signer,
      application_creation: application_creation,
      application_submission: application_submission,
      application_identifications: [application_identification]
    }
  end

  let(:application_identification) do
    {
      identification_id: "Exchange"
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

  let(:sender) do
    { sender_code: "a unique id" }
  end

  let(:receiver) do
    { recipient_code: "a unique id" }
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

  let(:transfer_activity) do
    {
      transfer_id: {identification_id: '2163565'},
      transfer_date: {date_time: DateTime.now},
      number_of_referrals: 1,
      recipient_code: 'MedicaidCHIP',
      state_code: 'ME'
    }
  end

  let(:person) do
    {
      id: "a-person-id",
      person_name: person_name,
      ssn: "012345678",
      sex: "SEX",
      race: "RACE",
      ethnicity: ["eth1", "eth2"],
      birth_date: person_birth_date,
      person_augmentation: person_augmentation,
      tribal_augmentation: tribal_augmentation
    }
  end

  let(:person_name) do
    {
      given: "First",
      middle: "",
      sur: "Last",
      full: "First Last",
    }
  end

  let(:person_birth_date) do
    { date: Date.today - 50 }  
  end
  
  let(:tribal_augmentation) do
    { recognized_tribe_indicator: true,
      american_indian_or_alaska_native_indicator: true,
      person_tribe_name: "Tribe Name",
      location_state_us_postal_service_code: "ME"
    }
  end

  let(:person_augmentation) do
    { us_veteran_indicator: false,
      married_indicator: true,
      pregnancy_status: pregnancy_status,
      preferred_languages: [preferred_language],
      incomes: [income],
      contacts: [contact_association],
      employments: [employment_association],
      persons: [person_association]
    }
  end

  let(:preferred_language) do
    { 
      language_name: "English" 
    } 
  end

  let(:pregnancy_status) do
    { status_indicator: false,
      # status_valid_date_range: status_valid_date_range,
      expected_baby_quantity: 0
    }
  end

  let(:status_valid_date_range) do
    { start_date: start_date, 
      end_date: end_date 
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

  let(:income) do
    { employment_source_text: "Acme",
      amount: 50000.00, 
      days_per_week: 5.0,
      hours_per_pay_period: 80.0, 
      hours_per_week: 40.0,
      category_code: "Salary", 
      description_text: "Robot", 
      subject_to_federal_restrictions_indicator: false, 
      date: income_date,
      earned_date_range: income_earned_date_range,
      frequency: income_frequency,
      payment_frequency: payment_frequency,
      source_organization_reference: source_organization_reference
    }
  end

  let(:income_date) do
    { date: Date.today,
      date_time: DateTime.now,
      year: "2021",
      year_month: "12/2021"
    }
  end

  let(:income_earned_date_range) do
    { start_date: start_date,
      end_date: end_date
    }
  end

  let(:start_date) do
    { date: Date.today,
      date_time: DateTime.now,
      year: "2020",
      year_month: "12/2020"
    }
  end

  let(:end_date) do
    { date: Date.today,
      date_time: DateTime.now,
      year: "2021",
      year_month: "12/2021"
    }
  end

  let(:income_frequency) do
    { frequency_code: "BiWeekly" } 
  end

  let(:payment_frequency) do
    { frequency_code: "Weekly" } 
  end

  let(:source_organization_reference) do
    { ref: "ref123" }
  end

  let(:contact_association) do
    { contact: contact,
      category_code: "Home"
    }
  end

  let(:contact) do
    { contact_email_id: "fake@test.com",
      mailing_address: mailing_address,
      telephone_number: contact_telephone
    }
  end

  let(:employment_association) do
    { begin_date: start_date,
      end_date: end_date,
      employer: employer
    }    
  end

  let(:employer) do
    { id: "em123",
      category_text: "Acme",
      organization_primary_contact_information: employer_contact
    }
  end

  let(:employer_contact) do
    { email: "fake@test.com",
      mailing_address: mailing_address,
      telephone_number: contact_telephone
    }
  end

  let(:mailing_address) do
    { address: structured_address }
  end

  let(:structured_address) do
    {
      location_street: location_street, 
      address_secondary_unit_text: "", 
      location_city_name: "Newark", 
      location_county_name: "Bergen", 
      location_county_code: "",
      location_state_us_postal_service_code: "NJ",
      location_postal_code: "01234",
    }
  end

  let(:location_street) do
    { street_full_text: "123 Easy Street" }
  end

  let(:contact_telephone) do
    { telephone: full_telephone }
  end

  let(:full_telephone) do
    { telephone_number_full_id: "1231231234",
      telephone_suffix_id: "0"
    }
  end

  let(:person_association) do
    { person: { ref: "pe123" },
      family_relationship_code: 01
    }
  end

  let(:tribal_augmentation) do
    { recognized_tribe_indicator: true,
      american_indian_or_alaska_native_indicator: true,
      person_tribe_name: "Tribe Name",
      location_state_us_postal_service_code: "ME"
    }
  end
  
  let(:senders) do
    [
      {category_code: 'Exchange'}
    ]
  end

  let(:receiver) do
    {
      category_code: 'Exchange'
    }
  end

  let(:application_identity) do
    {
      identification_id: "A UUID"
    }
  end

  let(:physical_household) do
    { 
      household_size_quantity: 1,
      household_member_references: [ { ref: "a-person-id" } ]
    }
  end


  let(:required_params) do
    {
      transfer_header: transfer_header,
      people: [person],
      insurance_application: insurance_application,
      senders: [sender],
      receivers: [receiver],
      physical_households: [physical_household]
    }
  end

  let(:optional_params) { { version: "2.4" , medicaid_households: [{}], authorized_representative: {} } }
  
  let(:all_params) { required_params.merge(optional_params) }


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
