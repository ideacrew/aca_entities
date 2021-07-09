# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ridp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::Operations::ValidateRidpPayloadXml,
               "given an unparsable xml" do

  let(:xml) do
    nil
  end

  let(:subject) do
    described_class.new.call(xml)
  end

  it "fails" do
    expect(subject.success?).to be_falsey
    expect(subject.failure).to eq :invalid_xml
  end
end

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::Operations::ValidateRidpPayloadXml,
               "given a schema valid request" do

  let(:file) do
    loc = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "..", "reference", "xml", "ridp", "RIDPPrimaryRequest.xml")
    File.expand_path(loc)
  end

  let(:xml) do
    File.read(file)
  end

  let(:subject) do
    described_class.new.call(xml)
  end

  it "is successful" do
    puts subject.inspect
    expect(subject.success?).to be_truthy
  end
end

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::Operations::ValidateRidpPayloadXml,
               "given a schema valid response" do

  let(:file) do
    loc = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "..", "reference", "xml", "ridp", "RIDPPrimaryResponse.xml")
    File.expand_path(loc)
  end

  let(:xml) do
    File.read(file)
  end

  let(:subject) do
    described_class.new.call(xml)
  end

  it "is successful" do
    expect(subject.success?).to be_truthy
  end
end

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::Operations::ValidateRidpPayloadXml,
               "given a schema invalid request" do

  let(:file) do
    loc = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "..", "reference", "xml", "ridp", "RIDPBogusPrimaryRequest.xml")
    File.expand_path(loc)
  end

  let(:xml) do
    File.read(file)
  end

  let(:subject) do
    described_class.new.call(xml)
  end

  it "fails" do
    expect(subject.success?).to be_falsey
  end
end