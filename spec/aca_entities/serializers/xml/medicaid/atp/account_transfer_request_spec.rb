# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest do
  let(:account_transfer_request) do
    AcaEntities::Medicaid::Atp::AccountTransferRequest.new(atp_properties)
  end

  let(:atp_properties) do
    {
      transfer_header: transfer_header,
      senders: senders,
      receivers: [receiver],

      insurance_application: insurance_application,
      medicaid_households: [],
      people: [person, dependent_person],
      tax_returns: [tax_return],
      physical_households: [{
        household_size_quantity: 1,
        household_member_references: [{ ref: "pe123" }]
      }]
    }
  end

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
      ssf_primary_contact: { contact_preference: 'Email', role_reference: role_reference },
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

  # let(:sender) do
  #   { sender_code: "Sender" }
  # end

  # let(:receiver) do
  #   { recipient_code: "Receiver" }
  # end

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
      medicaid_magi_eligibilities: [medicaid_magi_eligibility],
      chip_eligibilities: [trafficking_victim_category_eligibility_basis],
      temporarily_lives_outside_application_state_indicator: false,
      foster_care_indicator: false,
      fixed_address_indicator: true,
      referral_activity: referral_activity
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
      information_changes_indicator: false,
      medicaid_obligations_indicator: true
    }
  end

  let(:signature) do
    {
      signature_date: { date: DateTime.now.to_date }
    }
  end

  let(:role_reference) do
    { ref: "pe123" }
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

  let(:transfer_activity) do
    {
      transfer_id: { identification_id: '2163565' },
      transfer_date: { date_time: DateTime.now },
      number_of_referrals: 1,
      recipient_code: 'MedicaidCHIP',
      state_code: 'ME'
    }
  end

  let(:person) do
    { id: "pe123",
      birth_date: person_birth_date,
      ethnicities: ["ethnicity1", "ethnicity2"],
      person_name: person_name,
      sex: "Female",
      race: "RACE",
      ssn_identification: { identification_id: "012345678" },
      us_citizen_indicator: true,
      person_augmentation: person_augmentation,
      tribal_augmentation: tribal_augmentation }
  end

  let(:person_name) do
    {
      given: "First",
      middle: "M",
      sur: "Last"
    }
  end

  let(:person_birth_date) do
    { date: Date.today - 50 }
  end

  let(:tribal_augmentation) do
    { recognized_tribe_indicator: true,
      american_indian_or_alaska_native_indicator: true,
      person_tribe_name: "Tribe Name",
      location_state_us_postal_service_code: "ME" }
  end

  let(:person_augmentation) do
    { us_veteran_indicator: false,
      married_indicator: true,
      pregnancy_status: pregnancy_status,
      preferred_languages: [preferred_language],
      incomes: [income],
      contacts: [contact_association],
      employments: [employment_association],
      persons: [person_association] }
  end

  let(:preferred_language) do
    {
      language_name: "English"
    }
  end

  let(:pregnancy_status) do
    { status_indicator: false,
      status_valid_date_range: date_range,
      expected_baby_quantity: 0 }
  end

  let(:lawful_presence_status) do
    {
      arrived_before_1996_indicator: false,
      lawful_presence_status_eligibility: {
        eligibility_indicator: true
      }
    }
  end

  let(:medicaid_magi_eligibility) do
    {
      date_range: date_range,
      eligibility_determination: eligibility_determination,
      eligibility_indicator: true,
      eligibility_reason_text: "123",
      income_eligibility_basis: medicaid_magi_income_eligibility_basis
    }
  end

  let(:eligibility_determination) do
    {
      activity_identification: { identification_id: "MET00000000001887090" },
      activity_date: { date_time: DateTime.now }
    }
  end

  let(:medicaid_magi_income_eligibility_basis) do
    {
      status_code: "Complete",
      status_indicator: true,
      ineligibility_reason_text: "123",
      determination:
        {
          activity_identification: { identification_id: "MET00000000001887090" },
          activity_date: { date_time: DateTime.now }
        },
      income_compatibility: income_compatibility,
      state_threshold_fpl_percent: "116"
    }
  end

  let(:income_compatibility) do
    {
      verification_indicator: true,
      inconsistency_reason_text: "123",
      compatibility_determination:
        {
          activity_identification: { identification_id: "MET00000000001887090" },
          activity_date: { date_time: DateTime.now }
        },
      verification_method: "1"
    }
  end

  let(:trafficking_victim_category_eligibility_basis) do
    {
      status_indicator: false
    }
  end

  let(:referral_activity) do
    { activity_id: { identification_id: "01234" },
      activity_date: { date_time: DateTime.now },
      sender_reference: { ref: "Sender" },
      receiver_reference: { ref: "Receiver" },
      status: { status_code: "Initiated", overall_verification_status_code: "Y" } }
  end

  let(:income) do
    { employment_source_text: "Acme",
      amount: 50_000.00,
      days_per_week: 5,
      hours_per_pay_period: 80.0,
      hours_per_week: 40.0,
      category_code: "Wages",
      description_text: "Robot",
      subject_to_federal_restrictions_indicator: false,
      date: income_date,
      earned_date_range: date_range,
      frequency: income_frequency,
      payment_frequency: payment_frequency,
      source_organization_reference: source_organization_reference }
  end

  let(:income_date) do
    { date: Date.today }
  end

  let(:date_range) do
    { start_date: start_date,
      end_date: end_date }
  end

  let(:start_date) do
    { date: Date.today,
      date_time: DateTime.now,
      year: "2020",
      year_month: "12/2020" }
  end

  let(:end_date) do
    { date: Date.today,
      date_time: DateTime.now,
      year: "2021",
      year_month: "12/2021" }
  end

  let(:income_frequency) do
    { frequency_code: "BiWeekly" }
  end

  let(:payment_frequency) do
    { frequency_code: "Weekly" }
  end

  let(:source_organization_reference) do
    { ref: "MEORG000000209355581" }
  end

  let(:contact_association) do
    { is_primary_indicator: true,
      contact: contact,
      category_code: "Home" }
  end

  let(:contact) do
    { email_id: "fake@test.com",
      mailing_address: mailing_address,
      telephone_number: contact_telephone }
  end

  let(:employment_association) do
    { begin_date: start_date,
      end_date: end_date,
      employer: employer }
  end

  let(:employer) do
    {
      id: "MEORG000000209355581",
      category_text: "Acme",
      organization_primary_contact_information: employer_contact
    }
  end

  let(:employer_contact) do
    { email_id: "fake@test.com",
      mailing_address: mailing_address,
      telephone_number: contact_telephone }
  end

  let(:mailing_address) do
    { address: structured_address }
  end

  let(:structured_address) do
    {
      location_street: location_street,
      address_secondary_unit_text: "A",
      location_city_name: "Newark",
      location_county_name: "Bergen",
      location_county_code: "123",
      location_state_us_postal_service_code: "NJ",
      location_postal_code: "01234"
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
      telephone_suffix_id: "0" }
  end

  let(:person_association) do
    { person: { ref: "pe123" },
      family_relationship_code: "01" }
  end

  let(:tribal_augmentation) do
    { recognized_tribe_indicator: true,
      american_indian_or_alaska_native_indicator: true,
      person_tribe_name: "Tribe Name",
      location_state_us_postal_service_code: "ME" }
  end

  let(:senders) do
    [
      { id: "Sender",
        category_code: 'Exchange' }
    ]
  end

  let(:receiver) do
    { id: "Receiver",
      category_code: 'Exchange' }
  end

  let(:application_identity) do
    {
      identification_id: "A UUID"
    }
  end

  let(:tax_return) do
    {
      total_exemptions_quantity: 1,
      status_code: "0",
      tax_return_year: 2020,
      tax_household: tax_household,
      tax_return_includes_dependent_indicator: true
    }
  end

  let(:tax_household) do
    # {
    #   tax_dependents: [tax_dependent],
    #   household_incomes: [household_income]
    # }
    {
      household_incomes: [household_income],
      household_size_quantity: 2,
      # primary_tax_filer: { role_reference: role_reference },
      # spouse_tax_filer: { role_reference: role_reference },
      tax_dependents: [tax_dependent],
      household_member_references: [role_reference],
      household_size_change_expected_indicator: false
    }
  end

  let(:tax_dependent) do
    {
      role_reference: { ref: 'pe456' },
      claimed_by_custodial_parent_indicator: false,
      tin_identification: { identification_id: '012345678' }
    }
  end

  let(:dependent_person) do
    {
      id: "pe456",
      birth_date: person_birth_date,
      ethnicities: ["ethnicity1", "ethnicity2"],
      person_name: person_name,
      sex: "Female",
      race: "RACE",
      ssn_identification: { identification_id: "012345678" },
      us_citizen_indicator: true,
      person_augmentation: person_augmentation,
      tribal_augmentation: tribal_augmentation
    }
  end

  let(:household_income) do
    {
      monthly_income_greater_than_fpl: 0.00,
      income_type_code: 'CapitalGains',
      income_amount: 500.00,
      income_frequency: income_frequency,
      payment_frequency: payment_frequency,
      date: { date: Date.today },
      income_from_tribal_source: 120.00,
      source_organization_reference: { ref: 'MEORG000000209355581' },
      monthly_attested_medicaid_household_current_income: 0.00,
      annual_total_project_medicaid_household_current_income: 0.00,
      earned_date_range: date_range
    }
  end

  let(:mapper) { described_class.domain_to_mapper(account_transfer_request) }
  let(:schema) { Nokogiri::XML::Schema(File.open(schema_location)) }
  let(:schema_location) do
    loc = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..",
                    "reference", "xml", "atp",
                    "atp_service.xsd")
    File.expand_path(loc)
  end

  let(:schematron_location) do
    loc = File.join(
      File.dirname(__FILE__),
      "..", "..", "..", "..", "..",
      "reference", "xml", "atp"
    )
    File.expand_path(loc)
  end

  let(:business_error_ns) do
    {
      svrl: "http://purl.oclc.org/dsdl/svrl"
    }
  end

  it "is schema valid" do
    document = Nokogiri::XML(mapper.to_xml)
    # puts mapper.to_xml
    File.open('spec.xml', 'w') { |file| file.write(mapper.to_xml.to_s) }

    schema.validate(document).each do |error|
      puts "\n\n======= Schema Error ======="
      puts error.message
    end
    expect(schema.valid?(document)).to be_truthy
  end

  it "passes business rule validation" do
    # This test will always be green locally unless you have Java JDK installed on your machine!
    data = mapper.to_xml
    output, _err = Open3.capture3("java -jar atp_validator-0.1.0-jar-with-dependencies.jar --oneshot", stdin_data: data, binmode: true,
                                                                                                       chdir: schematron_location)
    error_doc = Nokogiri::XML(output)
    error_objects = error_doc.xpath("//svrl:failed-assert", business_error_ns).map do |node|
      location = node.at_xpath("@location").content
      message = node.at_xpath("svrl:text").content
      [location, message]
    end
    error_objects.each do |error|
      puts "\n\n======= Business Rule Failure ======="
      puts error.first
      puts error.last
    end
    expect(error_objects).to be_empty
  end
end