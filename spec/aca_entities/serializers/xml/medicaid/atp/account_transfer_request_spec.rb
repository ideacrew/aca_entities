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
      senders: [sender],
      receivers: [receiver],
      physical_households: [{
        household_size_quantity: 1,
        household_member_reference: []
      }],
      insurance_application: insurance_application,
      medicaid_households: [{}],
      people: [person]
    }
  end

  let(:transfer_header) do
    {
      transfer_id: "ABCDE",
      transfer_date: DateTime.now,
      number_of_referrals: 5,
      recipient_code: "MedicaidCHIP",
      state_code: "ME"
    }
  end

  let(:insurance_application) do
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

  let(:sender) do
    { sender_code: "a unique id" }
  end

  let(:receiver) do
    { recipient_code: "a unique id" }
  end

  let(:insurance_applicant) do
    { 
      role_reference: { ref: "pe123" },
      esi_eligible_indicator: false,
      age_left_foster_care: 14,
      foster_care_state: "n/a",
      had_medicaid_during_foster_care_indicator: false,
      blindness_or_disability_indicator: false,
      lawful_presence_status: lawful_presence_status, 
      long_term_care_indicator: false,
      chip_eligibilities: [trafficking_victim_category_eligibility_basis],
      temporarily_lives_outside_application_state_indicator: false, 
      foster_care_indicator: false
    }
  end

  let(:sender) do
    { sender_code: "a unique id" }
  end

  let(:receiver) do
    { recipient_code: "a unique id" }
  end

  let(:person) do
    {
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
      first_name: "First",
      middle_name: "",
      last_name: "Last",
      name_sfx: "",
      name_pfx: "",
      full_name: "First Last",
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
      status_valid_date_range: status_valid_date_range,
      expected_baby_quantity: 1
    }
  end

  let(:status_valid_date_range) do
    { end_date: end_date }
  end

  let(:ssf_primary_contact) do
    {
      role_reference: { ref: "a-person-id" },
      contact_preference: "Mail"
    }
  end

  let(:ssf_signer) { ssf_attestation }
    
  let(:ssf_attestation) do
    { non_perjury_indicator: true,
      not_incarcerated_indicator: true,
      information_changes_indicator: false
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
  
  let(:mapper) { described_class.domain_to_mapper(account_transfer_request) }
  let(:schema) { Nokogiri::XML::Schema(File.open(schema_location)) }
  let(:schema_location) do
    loc = File.join(
      File.dirname(__FILE__),
      "..", "..", "..", "..", "..",
      "reference", "xml", "atp",
      "atp_service.xsd"
    )
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