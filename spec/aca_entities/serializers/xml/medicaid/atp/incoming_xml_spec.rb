# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest do
  let(:sample_location) do
    loc = File.join(
      File.dirname(__FILE__),
      "..", "..", "..", "..", "..",
      "reference", "xml", "atp",
      "sample.xml"
    )
    File.expand_path(loc)
  end

  let(:sample_xml) {File.read(sample_location)}

  let(:mapper) { described_class.parse(sample_xml) }

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

  it "can parse incoming xml" do
    expect { mapper }.not_to raise_error
  end

  it "can parse elements" do
    #TODO Expand/add examples!!
    expect(mapper.transfer_header.transfer_activity.transfer_id.identification_id).to eq("MET00000000001861298")
  end

  it "sample is schema valid" do
    document = Nokogiri::XML(File.open(sample_location))
    schema.validate(document).each do |error|
      puts "\n\n======= Schema Error ======="
      puts error.message
    end
    expect(schema.valid?(document)).to be_truthy
  end

    it "passes business rule validation" do
    data = sample_xml
    output, _err = Open3.capture3("java -jar atp_validator-0.1.0-jar-with-dependencies.jar --oneshot", stdin_data: data, binmode: true, chdir: schematron_location)
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