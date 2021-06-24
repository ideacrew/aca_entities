# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest do
  let(:sample_xml) {File.read('spec/support/atp/sample_payloads/sample.xml')}

  let(:mapper) { described_class.parse(sample_xml) }

  it "parse should not raise an error" do
    expect { mapper }.not_to raise_error
  end

  it "parses xml into ruby object" do
    expect(mapper).to be_a described_class
  end

  it "can parse elements" do
    # TODO: Expand/add examples!!
    expect(mapper.transfer_header.transfer_activity.transfer_id.identification_id).to eq("fakeidme12345")
  end

end