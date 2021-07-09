# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ridp'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::Operations::SecondaryRequestToXml,
               "given a secondary request that results in a bogus xml" do

  let(:secondary_request) do
    instance_double(
      ::AcaEntities::Fdsh::Ridp::H139::SecondaryRequest
    )
  end

  let(:bogus_xml) do
    <<-XMLCODE
     <xml_tag xmlns="urn:whatever">
     </xml_tag>
    XMLCODE
  end

  let(:mock_mapper) do
    instance_double(
      ::AcaEntities::Serializers::Xml::Fdsh::Ridp::Request,
      to_xml: bogus_xml
    )
  end

  let(:subject) do
    described_class.new.call(secondary_request)
  end

  before :each do
    allow(::AcaEntities::Serializers::Xml::Fdsh::Ridp::Request).to receive(
      :domain_to_mapper
    ).with(
      secondary_request, "secondary_request"
    ).and_return(mock_mapper)
  end

  it "fails" do
    expect(subject.success?).to be_falsey
  end
end

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::Operations::SecondaryRequestToXml,
               "given a secondary request that results in a valid xml" do

  let(:secondary_request) do
    instance_double(
      ::AcaEntities::Fdsh::Ridp::H139::SecondaryRequest
    )
  end

  let(:file) do
    loc = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "..", "reference", "xml", "ridp", "RIDPSecondaryRequest.xml")
    File.expand_path(loc)
  end

  let(:valid_xml) do
    File.read(file)
  end

  let(:mock_mapper) do
    instance_double(
      ::AcaEntities::Serializers::Xml::Fdsh::Ridp::Request,
      to_xml: valid_xml
    )
  end

  let(:subject) do
    described_class.new.call(secondary_request)
  end

  before :each do
    allow(::AcaEntities::Serializers::Xml::Fdsh::Ridp::Request).to receive(
      :domain_to_mapper
    ).with(
      secondary_request, "secondary_request"
    ).and_return(mock_mapper)
  end

  it "succeeds" do
    expect(subject.success?).to be_truthy
  end
end