# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ridp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::PrimaryResponse do

  let(:file) do
    loc = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "reference", "xml", "ridp", "RIDPPrimaryResponse.xml")
    File.expand_path(loc)
  end

  before do
    xml = Nokogiri::XML(File.open(file))
    @result = described_class.parse(xml.root.canonicalize, :single => true)
  end

  it "result to be a ruby object" do
    expect(@result).to be_a described_class
  end
end