# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp'

RSpec.describe AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest do
  let(:account_transfer_request) do
    AcaEntities::Medicaid::Atp::AccountTransferRequest.new(atp_properties)
  end

  let(:atp_properties) do
    {
      transfer_header: transfer_header,
      sender: {},
      receiver: {},
      physical_household: {
        household_size_quantity: 1,
        household_member_reference: []
      },
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
      attestation: attestation
    }
  end

  let(:application_metadata) do
    {
      application_id: "an application id",
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

  let(:person) do
    {
      person_name: {
        first_name: "A FIRST NAME",
        last_name: "A LAST NAME"
      },
      demographic: {
        dob: Date.today,
        gender: "A GENDER"
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

  it "should be schema valid" do
    document = Nokogiri::XML(mapper.to_xml)
    expect(schema.valid?(document)).to be_truthy
  end
end