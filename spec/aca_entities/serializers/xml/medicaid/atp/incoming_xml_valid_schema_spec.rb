# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/medicaid/atp'

RSpec.describe AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest do
  
  let(:sample_location) do
    loc = File.join(
      File.dirname(__FILE__),
      "..", "..", "..", "..", "..",
      "reference", "xml", "atp",
      "sample_payloads.xml"
    )
    File.expand_path(loc)
  end

  let(:sample_xml) {File.read(sample_location)}

  # Split sample file on comments (ignoring the first one) and store just the payloads
  let(:payloads) {sample_xml.split(/<!-- payload (?:1[2-9]+|[2-9]+) -->/)}
  
  let(:schema_location) do
    loc = File.join(
      File.dirname(__FILE__),
      "..", "..", "..", "..", "..",
      "reference", "xml", "atp",
      "atp_service.xsd"
    )
    File.expand_path(loc)
  end

  let(:schema) { Nokogiri::XML::Schema(File.open(schema_location)) }

  it "is schema valid" do
    payloads.each_index do |i|
      doc = Nokogiri::XML(payloads[i])
      schema.validate(doc).each do |error|
        puts "\n\n======= Schema Error in Payload #{i+1} ======="
        puts error.message
      end 
      expect(schema.valid?(doc)).to be_truthy
    end
  end
end