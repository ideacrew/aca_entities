# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest do

  let(:sample_xml) {File.read('spec/support/atp/sample_payloads/sample_inbound_payloads.xml')}

  # Split sample file on comments (ignoring the first one) and store just the payloads
  let(:payloads) {sample_xml.split(/<!-- payload (?:1[0-9]+|[2-9]+) -->/)}

  # let(:sample_xml) {File.read('spec/support/atp/sample_payloads/sample 3.xml')}
  # let(:payloads) {[sample_xml]}

  # let(:mapper) { described_class.parse(sample_xml) }

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

  let(:mapper) { described_class.parse(sample_xml) }

  it "parse should not raise an error" do
    payloads.each do |p|
      expect { described_class.parse(p) }.not_to raise_error
    end
  end

  it "parses xml into ruby object" do
    payloads.each do |p|
      expect(described_class.parse(p)).to be_a described_class
    end
  end

  it "can parse elements" do
    # TODO: Expand/add examples!!
    # expect(mapper.transfer_header.transfer_activity.transfer_id.identification_id).to eq("fakeidme12345")
  end

  # it "passes business rule validation" do
  #   # This test will always be green locally unless you have Java JDK installed on your machine!
  #   payloads.each do |p|
  #     data = p
  #     output, _err = Open3.capture3("java -jar atp_validator-0.1.0-jar-with-dependencies.jar --oneshot", stdin_data: data, binmode: true,
  #                                                                                                       chdir: schematron_location)
  #     error_doc = Nokogiri::XML(output)
  #     error_objects = error_doc.xpath("//svrl:failed-assert", business_error_ns).map do |node|
  #       location = node.at_xpath("@location").content
  #       message = node.at_xpath("svrl:text").content
  #       [location, message]
  #     end
  #     error_objects.each do |error|
  #       puts "\n\n======= Business Rule Failure ======="
  #       puts error.first
  #       puts error.last
  #     end
  #     expect(error_objects).to be_empty
  #   end
  # end
end