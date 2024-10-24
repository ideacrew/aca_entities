# frozen_string_literal: true

# lib/aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_name.rb

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/pvc'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Request::IndividualRequest do
  let(:person_hash) do
    { PersonName: { PersonGivenName: 'John', PersonMiddleName: 'Doe', PersonSurName: 'Smith' },
      PersonSSNIdentification: { SSNIdentification: "123456789" },
      PersonBirthDate: Date.today }
  end
  let(:entity) { AcaEntities::Fdsh::Pvc::Dmf::Request::IndividualRequest.new(person_hash)}

  it 'returns a serialized object' do
    result = described_class.domain_to_mapper(entity)
    expect(result).to be_a(AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Request::IndividualRequest)
  end

  it 'should convert to xml' do
    result = described_class.domain_to_mapper(entity)
    expect(result.to_xml.split("\n").first).to eq '<?xml version="1.0"?>'
    expect(result.to_xml.split("\n")[1]).to match(/<ext:IndividualRequest xmlns:ext=/)
    expect(result.to_xml.split("\n")[2]).to eq '  <nc:PersonSSNIdentification>'
    expect(result.to_xml.split("\n")[5]).to eq '  <nc:PersonName>'
    expect(result.to_xml.split("\n")[6]).to eq '    <nc:PersonGivenName>John</nc:PersonGivenName>'
  end
end