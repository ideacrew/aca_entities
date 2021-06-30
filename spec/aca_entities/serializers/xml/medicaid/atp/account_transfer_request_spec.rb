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
      physical_household: [{
        household_size_quantity: 1,
        household_member_reference: []
      }],
      insurance_application: insurance_application,
      medicaid_household: {},
      person: person
    }
  end

  let(:transfer_header) do
    {
      transfer_id: "ABCDE",
      transfer_date: DateTime.now,
      number_of_referrals: 5,
      recipient_code: "MedicaidCHIP"
    }
  end

  let(:insurance_application) do
    {
      application_metadata: application_metadata,
      attestation: attestation,
      applicants: []
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

  let(:attestation) do
    {
      attested_if_information_changes_indicator: false,
      attested_non_perjury_indicator: false,
      tax_return_access_indicator: false
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
      person_name: {
        first_name: "A FIRST NAME",
        last_name: "A LAST NAME"
      },
      demographic: {
        dob: Date.today,
        gender: "A GENDER",
      },
      citizenship_immigration_status_information: {
        us_citizen: true
      },
      native_american_information: {
        is_native_american_or_alaska_native: false
      }
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