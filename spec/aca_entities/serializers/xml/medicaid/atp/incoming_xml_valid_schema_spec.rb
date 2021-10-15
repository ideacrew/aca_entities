# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest do

  let(:sample_location) do
    loc = File.join(
      File.dirname(__FILE__),
      "..", "..", "..", "..", "..",
      "support", "atp", "sample_payloads",
      "sample_payloads.xml"
    )
    File.expand_path(loc)
  end

  let(:sample_xml) {File.read(sample_location)}

  # Split sample file on comments (ignoring the first one) and store just the payloads
  let(:payloads) {sample_xml.split(/<!-- payload (?:1[0-9]+|[2-9]+) -->/)}

  let(:schema_location) do
    loc = File.join(
      File.dirname(__FILE__),
      "..", "..", "..", "..", "..",
      "reference", "xml", "atp",
      "atp_service.xsd"
    )
    File.expand_path(loc)
  end

  ############################
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
  ##############################

  let(:schema) { Nokogiri::XML::Schema(File.open(schema_location)) }

  it "is schema valid" do
    # Line numbers must be adjusted for accurate error messages
    line_adjust = 0
    payloads.each_index do |i|
      doc = Nokogiri::XML(payloads[i])
      schema.validate(doc).each do |error|
        # Get payload specific line number from error message and adjust
        error_line_no = error.to_s[0..2].to_i + line_adjust
        puts "\n\n======= Schema Error in Payload #{i + 1} at line #{error_line_no} ======="
        # Ignore unhelpful line number
        # puts error.message.to_s[7..]
      end
      expect(schema.valid?(doc)).to be_truthy

      line_adjust += payloads[i].count("\n")
    end
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
