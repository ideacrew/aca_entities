# frozen_string_literal: true

require "spec_helper"
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/atp/transformers/cv/family'
require 'aca_entities/medicaid/atp'
require 'aca_entities/medicaid/contracts/account_transfer_request_contract'
require 'aca_entities/atp/transformers/aces/family'
require 'aca_entities/atp/operations/aces/generate_xml'
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

RSpec.describe AcaEntities::Atp, "given an inbound XML with rich applicant and medicaid eligiblity data, example 1" do

  let(:input_xml) do
    File.read(
      File.expand_path(
        File.join(
          File.dirname(__FILE__),
          "../../",
          "support/atp/sample_payloads/step_1.xml"
        )
      )
    )
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

  it "parses payloads without error" do
    expect(applicants).not_to be_empty
  end
end

RSpec.describe AcaEntities::Atp, "given an inbound XML with rich applicant and medicaid eligiblity data, example 2" do

  let(:input_xml) do
    File.read(
      File.expand_path(
        File.join(
          File.dirname(__FILE__),
          "../../",
          "support/atp/sample_payloads/step_2.xml"
        )
      )
    )
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

  it "parses payloads without error" do
    expect(applicants).not_to be_empty
  end
end

RSpec.describe AcaEntities::Atp, "given an inbound XML with rich applicant and medicaid eligiblity data, example 3" do

  let(:input_xml) do
    File.read(
      File.expand_path(
        File.join(
          File.dirname(__FILE__),
          "../../",
          "support/atp/sample_payloads/step_3.xml"
        )
      )
    )
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

  it "parses payloads without error" do
    expect(applicants).not_to be_empty
  end
end

RSpec.describe AcaEntities::Atp, "given an inbound XML with rich applicant and medicaid eligiblity data, example 4" do

  let(:input_xml) do
    File.read(
      File.expand_path(
        File.join(
          File.dirname(__FILE__),
          "../../",
          "support/atp/sample_payloads/step_4.xml"
        )
      )
    )
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

  it "parses payloads without error" do
    expect(applicants).not_to be_empty
  end
end