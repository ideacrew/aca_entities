# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ridp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::Request do

  let(:primary_request_file) do
    loc = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "reference", "xml", "ridp", "RIDPPrimaryRequest.xml")
    File.expand_path(loc)
  end

  let(:secondary_request_file) do
    loc = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "reference", "xml", "ridp", "RIDPSecondaryRequest.xml")
    File.expand_path(loc)
  end

  describe "primary request" do
    before do
      xml = Nokogiri::XML(File.open(primary_request_file))
      @result1 = described_class.parse(xml.root.canonicalize, :single => true)
    end

    it "result to be a ruby object" do
      expect(@result1).to be_a described_class
      expect(@result1.PrimaryRequest).to be_a AcaEntities::Serializers::Xml::Fdsh::Ridp::PrimaryRequest
      expect(@result1.SecondaryRequest).to be nil
    end
  end

  describe "secondary request" do
    before do
      xml = Nokogiri::XML(File.open(secondary_request_file))
      @result2 = described_class.parse(xml.root.canonicalize, :single => true)
    end

    it "result to be a ruby object" do
      expect(@result2).to be_a described_class
      expect(@result2.PrimaryRequest).to be nil
      expect(@result2.SecondaryRequest).to be_a AcaEntities::Serializers::Xml::Fdsh::Ridp::SecondaryRequest
    end
  end
end
