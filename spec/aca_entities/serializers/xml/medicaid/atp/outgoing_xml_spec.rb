# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/atp/operations/aces/generate_xml'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest do
  let(:sample_xml) {File.read('spec/support/atp/sample_payloads/sample.xml')}

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

  it "passes business rule validation" do
    data = sample_xml

    output, _err = Open3.capture3("java -jar atp_validator-0.3.0-jar-with-dependencies.jar --oneshot", stdin_data: data, binmode: true,
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

RSpec.describe AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest, "encoded from a file with additional referral reasons" do
  let(:payload) { File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/multiple_reason_L_cv_payload.json")) }
  let(:payload_hash) { JSON.parse(payload, symbolize_names: true) }

  let(:xml_payload) do
    result = AcaEntities::Atp::Operations::Aces::GenerateXml.new.call(payload_hash.to_json)
    result.value!
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

  it "passes business rule validation" do
    data = xml_payload

    output, _err = Open3.capture3("java -jar atp_validator-0.3.0-jar-with-dependencies.jar --oneshot", stdin_data: data, binmode: true,
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