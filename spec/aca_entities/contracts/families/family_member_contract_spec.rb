# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Families::FamilyMemberContract, dbclean: :after_each do

  let!(:person_name) do
    {
      first_name: 'first name',
      middle_name: 'first name',
      last_name: 'last name'
    }
  end

  let!(:person_health) do
    {
      is_tobacco_user: 'unknown',
      is_physically_disabled: false
    }
  end

  let!(:person_demographics) do
    {
      ssn: "123456789",
      no_ssn: false,
      gender: 'male',
      dob: Date.today,
      is_incarcerated: false
    }
  end

  let!(:person_reference) do
    {
      hbx_id: '1234',
      first_name: 'first name',
      middle_name: 'middle name',
      last_name: 'last name',
      dob: Date.today,
      gender: 'male',
      ssn: nil
    }
  end

  let!(:person_relationships) do
    [
      {
        kind: 'child',
        relative: person_reference
      }
    ]
  end

  let(:documents) { [] }

  let(:event_response) do
    [
      {
        received_at: DateTime.now,
        body: "response"
      }
    ]
  end

  let(:event_request) do
    [
      {
        requested_at: DateTime.now,
        body: "request"
      }
    ]
  end

  let!(:lawful_presence_determination) do
    {
      vlp_verified_at: DateTime.now,
      vlp_authority: "curam",
      vlp_document_id: nil,
      citizen_status: nil,
      citizenship_result: nil,
      qualified_non_citizenship_result: nil,
      aasm_state: "verification_successful",
      ssa_responses: event_response,
      ssa_requests: event_request,
      vlp_responses: event_response,
      vlp_requests: event_request
    }
  end

  let(:vlp_documents) do
    [
      {
        title: "untitled",
        creator: "dchl",
        subject: "Naturalization Certificate",
        description: nil,
        publisher: "dchl",
        contributor: nil,
        date: Date.today,
        type: "text",
        format: "application/octet-stream",
        identifier: nil,
        source: "enroll_system",
        language: "en",
        relation: nil,
        coverage: nil,
        rights: 'public',
        tags: [], size: nil,
        doc_identifier: nil,
        alien_number: "047122478",
        i94_number: nil,
        visa_number: nil,
        passport_number: nil,
        sevis_id: nil,
        naturalization_number: "30121997",
        receipt_number: nil,
        citizenship_number: nil,
        card_number: nil,
        country_of_citizenship: nil,
        expiration_date: DateTime.now,
        issuing_country: nil,
        status: "not submitted",
        verification_type: "Citizenship",
        comment: nil
      }
    ]
  end

  let(:ridp_documents) do
    [
      {
        title: "license - back.pdf",
        creator: "mhc",
        subject: "license - back.pdf",
        description: nil,
        publisher: "mhc",
        contributor: nil,
        date: Date.today,
        type: "text",
        format: "application/octet-stream",
        identifier: nil, source: "enroll_system",
        language: "en", relation: nil, coverage: nil,
        rights: 'public',
        tags: [],
        size: nil,
        doc_identifier: nil,
        status: "downloaded",
        ridp_verification_type: "Identity",
        comment: nil,
        uploaded_at: Date.today
      }
    ]
  end

  let(:verification_type_history_elements) do
    [
      { verification_type: "Social Security Number",
        action: "SSA Hub Request",
        modifier: "Enroll App",
        update_reason: "Hub request",
        event_response_record: {},
        event_request_record: {} }
    ]
  end

  let!(:consumer_role) do
    {
      five_year_bar: false,
      requested_coverage_start_date: Date.today,
      aasm_state: "fully_verified",
      is_applicant: true,
      birth_location: nil,
      marital_status: nil,
      is_active: true,
      is_applying_coverage: true,
      raw_event_responses: [],
      bookmark_url: nil,
      admin_bookmark_url: nil,
      contact_method: "Only Paper communication",
      language_preference: "English",
      is_state_resident: true,
      identity_validation: "na",
      application_validation: "na",
      identity_update_reason: nil,
      application_update_reason: nil,
      identity_rejected: false,
      application_rejected: false,
      documents: [],
      vlp_documents: vlp_documents,
      ridp_documents: ridp_documents,
      verification_type_history_elements: verification_type_history_elements,
      lawful_presence_determination: lawful_presence_determination,
      local_residency_responses: event_response,
      local_residency_requests: event_request
    }
  end

  let!(:resident_role) do
    {
      is_applicant: true,
      is_active: true,
      bookmark_url: "/families/home",
      is_state_resident: true,
      residency_determined_at: Date.today,
      contact_method: "Paper and Electronic communications",
      language_preference: "English",
      local_residency_responses: event_response,
      lawful_presence_determination: lawful_presence_determination
    }
  end

  let!(:individual_market_transitions) do
    [
      {
        role_type: "consumer",
        start_on: Date.today,
        end_on: Date.today,
        reason_code: "initial_individual_market_transition_created_using_data_migration",
        submitted_at: DateTime.now
      }
    ]
  end

  let!(:verification_types) do
    [
      {
        type_name: "DC Residency",
        validation_status: "attested",
        applied_roles: ["consumer_role"],
        update_reason: nil,
        rejected: false,
        external_service: nil,
        due_date: Date.today,
        due_date_type: nil,
        updated_by: person_reference,
        inactive: nil,
        vlp_documents: []
      }
    ]
  end

  let(:broker_agency_reference) do
    { hbx_id: "1233444", market_kind: 'both', name: 'broker agency', dba: nil, display_name: nil, fein: '089441964', corporate_npn: nil }
  end

  let!(:broker_role) do
    {
      aasm_state: "decertified",
      npn: "2355863",
      broker_agency_reference: broker_agency_reference,
      provider_kind: "broker",
      reason: "Broker has obtained carrier appointments and has completed training.",
      market_kind: "both",
      languages_spoken: ["en"],
      working_hours: false,
      accept_new_clients: nil,
      license: nil,
      training: nil,
      carrier_appointments:
            {
              aetna_health_inc: nil,
              aetna_life_insurance_company: nil,
              carefirst_bluechoice_inc: nil,
              group_hospitalization_and_medical_services_inc: nil,
              kaiser_foundation: nil, optimum_choice: nil,
              united_health_care_insurance: nil,
              united_health_care_mid_atlantic: nil
            }
    }
  end

  let(:addresses) do
    [
      {
        kind: "home",
        address_1: "S Street NW",
        address_2: "",
        address_3: "",
        city: "Washington",
        county: "",
        state: "DC",
        location_state_code: nil,
        full_text: nil,
        zip: "20009",
        country_name: ""
      }
    ]
  end

  let(:phones) do
    [
      {
        kind: "home",
        country_code: "",
        area_code: "202",
        number: "2991290",
        extension: "",
        primary: true,
        full_phone_number: "2022991290"
      }
    ]
  end

  let(:emails) do
    [
      {
        kind: "home",
        address: "test@gmail.com"
      }
    ]
  end

  let(:timestamp) do
    {
      submitted_at: DateTime.now,
      created_at: DateTime.now,
      modified_at: DateTime.now
    }
  end

  let!(:person) do
    {
      hbx_id: '1001',
      is_active: true,
      is_disabled: false,
      no_dc_address: nil,
      no_dc_address_reason: nil,
      is_homeless: nil,
      is_temporarily_out_of_state: nil,
      age_off_excluded: nil,
      is_applying_for_assistance: nil,
      person_name: person_name,
      person_health: person_health,
      person_demographics: person_demographics,
      person_relationships: person_relationships,
      consumer_role: consumer_role,
      resident_role: resident_role,
      individual_market_transitions: individual_market_transitions,
      verification_types: verification_types,
      broker_role: broker_role,
      addresses: addresses,
      phones: phones,
      emails: emails,
      documents: documents,
      timestamp: timestamp
    }
  end

  let(:hbx_enrollment_exemptions) { [] }

  let(:applicant_reference) do
    [{
      first_name: "first name",
      last_name: "last name",
      dob: Date.today,
      person_hbx_id: "33333333",
      encrypted_ssn: nil
    }]
  end

  let(:required_params) do
    {
      hbx_id: '1001',
      is_primary_applicant: false,
      is_consent_applicant: true,
      is_coverage_applicant: nil,
      is_active: true,
      magi_medicaid_application_applicants: applicant_reference,
      person: person,
      timestamp: timestamp
    }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :is_primary_applicant })
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(person: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be a hash')
      end

      it 'should return error message' do
        result = subject.call(required_params.merge(is_primary_applicant: nil))
        expect(result.errors.messages.first.text).to eq('must be boolean')
      end
    end
  end
end
