# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ridp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::Request do

  let(:file) do
    loc = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "reference", "xml", "ridp", "RIDPPrimaryRequest.xml")
    File.expand_path(loc)
  end

  before do
    xml = Nokogiri::XML(File.open(file))
    r = described_class.parse(xml.root.canonicalize, :single => true)
  end

  it "" do

  end

end
