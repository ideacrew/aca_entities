# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/atp/transformers/aces/family'
require 'aca_entities/atp/operations/aces/generate_xml'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp/account_transfer_request'
require 'pry'
require 'open3'

RSpec.describe AcaEntities::Atp::Operations::Aces::GenerateXml  do
  describe 'When a valid json file is passed' do

    let(:payload) { File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json")) }

    let(:schematron_location) do
      loc = File.join(
        File.dirname(__FILE__),
        "..", "..", "..", "..",
        "reference", "xml", "atp"
      )
      File.expand_path(loc)
    end

    let(:business_error_ns) do
      {
        svrl: "http://purl.oclc.org/dsdl/svrl"
      }
    end

    it 'should parse and then transform when transform_mode set to batch' do
      result = described_class.new.call(payload)
      _example_output_xml = File.read(Pathname.pwd.join('spec/support/atp/sample_payloads/simple_L_transformed_payload.xml'))
      p result.value!
      expect(result.success?).to be_truthy
    end

    it "passes business rule validations" do
      result = described_class.new.call(payload)
      data = result.value!

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
end