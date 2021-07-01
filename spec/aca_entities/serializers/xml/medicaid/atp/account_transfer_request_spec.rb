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
      sender: [sender],
      receiver: [receiver],
      physical_households: [{
        household_size_quantity: 1,
        household_member_reference: []
      }],
      insurance_application: insurance_application,
      medicaid_household: [{}],
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
      # application_metadata: application_metadata,
      # attestation: attestation,
      insurance_applicants: [applicant],
      requesting_financial_assistance: false, 
      requesting_medicaid: false, 
      ssf_primary_contact: { ssf_primary_contact }, 
      tax_return_access_indicator: false
    }
  end

  # let(:application_metadata) do
  #   {
  #     application_ids: [{ identification_id: "an application id" }],
  #     application_signature_date: DateTime.now,
  #     creation_date: DateTime.now,
  #     submission_date: DateTime.now,
  #     identification_category_text: "ID CATEGORY TEXT",
  #     financial_assistance_indicator: false,
  #     medicaid_determination_indicator: false
  #   }
  # end

  # let(:attestation) do
  #   {
  #     attested_if_information_changes_indicator: false,
  #     attested_non_perjury_indicator: false,
  #     tax_return_access_indicator: false
  #   }
  # end

  let(:sender) do
    { sender_code: "a unique id" }
  end

  let(:receiver) do
    { recipient_code: "a unique id" }
  end

  let(:insurance_applicant) do
    { 
      role_reference: { ref: "a-person-id" },
      age_left_foster_care: 14,
      blindness_or_disability_indicator: false,
      lawful_presence_status: { lawful_presence_status }, 
      temporarily_lives_outside_application_state_indicator: false, 
    }
  end

  let(:person) do
    {
      person_name: { person_name },
      ssn: "012345678",
      sex: "SEX",
      race: "RACE",
      ethnicity: "ETHNICITY", 
      birth_date: Date.today,
      person_augmentation: { person_augmentation },
      # demographic: {
      #   dob: Date.today,
      #   gender: "A GENDER",
      # },
      # citizenship_immigration_status_information: {
      #   us_citizen: true
      # },
      # native_american_information: {
      #   is_native_american_or_alaska_native: false
      # }
    }
  end

  let(:person_name) do
    {
      first_name: "Dickie",
      middle_name: "",
      last_name: "Moltisanti",
      name_sfx: "",
      name_pfx: "",
      full_name: "Dicky Moltisanti",
    }

  end

  let(:person_augmentation) do
    {
      married_indicator: true,
      preferred_languages: [{ language_name: "English" }],
      contacts: [{ contact_information_association }],  
      persons: [person_association],
    }

  end

  let(:ssf_primary_contact) do
    {
      role_reference: { ref: "a-person-id" },
      contact_preference: "Mail"
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

  let(:contact_information_association) do
    {
      contact: { contact_information },
      category_code: "Home"
    }

  end

  let(:contact_information) do
    {
      contact_email_id: "satriales@deli.com",
      mailing_address: { structured_address },
      telephone_number: { full_telephone }
    }
  end

  let(:structured_address) do
    {
      location_street: { street_full_text: "123 Easy Street" }, 
      address_secondary_unit_text: "", 
      location_city_name: "Newark", 
      location_county_name: "Bergen", 
      location_county_code: "",
      location_state_us_postal_service_code: "NJ",
      location_postal_code: "01234",
    }
  end

  let(:full_telephone) do
    {
      telephone_number_full_id: "1235556666",
      telephone_suffix_id: ""
    }
  end

  let(:person_association) do
    {
      person: { person_id: "a-person-id" },
      family_relationship_code: "19"
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
    puts document
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