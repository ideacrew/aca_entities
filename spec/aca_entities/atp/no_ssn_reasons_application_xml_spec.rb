# frozen_string_literal: true

require "spec_helper"
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/atp/transformers/cv/family'
require 'aca_entities/medicaid/atp'
require 'aca_entities/medicaid/contracts/account_transfer_request_contract'
require 'aca_entities/atp/transformers/aces/family'
require 'aca_entities/atp/operations/aces/generate_xml'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp/account_transfer_request'
require "support/atp/inbound_build_application"
require "aca_entities/atp/transformers/cv/phone"
require "aca_entities/atp/transformers/cv/other_questions"
require "aca_entities/atp/transformers/cv/deduction"
require "aca_entities/atp/transformers/cv/income"
require "aca_entities/atp/transformers/cv/contact_info"
require "aca_entities/atp/functions/lawful_presence_determination_builder"
require "aca_entities/atp/functions/address_builder"
require "aca_entities/functions/age_on"
require "aca_entities/atp/functions/relationship_builder"

RSpec.describe AcaEntities::Atp, "given an inbound XML with multiple 'no ssn' reasons" do

  let(:input_xml) do
    File.read(
      File.expand_path(
        File.join(
          File.dirname(__FILE__),
          "../../",
          "support/atp/sample_payloads/sample_no_ssn_reason_payload.xml"
        )
      )
    )
    # SOME SAMPLE XML WILL GO HERE OR BE LOADED FROM A FILE
  end

  let(:parsed_xml) do
    record = AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(input_xml)
    record.is_a?(Array) ? record.first : record
  end

  let(:transformed_family) do
    ::AcaEntities::Atp::Transformers::Cv::Family.transform(parsed_xml.to_hash(identifier: true))
  end

  let(:applicants) do
    transformed_family[:family][:magi_medicaid_applications].first[:applicants]
  end

  it "creates a family with correct no SSN reasons of 'AppliedSSN' for the correct applicant" do
    applicant = applicants.detect do |app|
      app[:person_hbx_id] == "IDC1003159"
    end
    expect(applicant[:non_ssn_apply_reason]).to eq nil
    expect(applicant[:is_ssn_applied]).to eq true
  end

  it "creates a family with correct no SSN reasons of 'other' for the correct applicant" do
    applicant = applicants.detect do |app|
      app[:person_hbx_id] == "IDC1002699"
    end
    expect(applicant[:non_ssn_apply_reason]).to eq "other"
    expect(applicant[:is_ssn_applied]).to eq false
  end
end