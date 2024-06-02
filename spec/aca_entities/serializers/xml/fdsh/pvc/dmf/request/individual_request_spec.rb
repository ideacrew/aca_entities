# frozen_string_literal: true

# lib/aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_name.rb

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/pvc'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Request::IndividualRequest do
  describe 'domain_to_mapper' do
    let(:person_hash) do
      { PersonName: { PersonGivenName: 'John', PersonMiddleName: 'Doe', PersonSurName: 'Smith' }, PersonSSNIdentification: '564356789',
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
      expect(result.to_xml.split("\n")[1]).to eq '<IndividualRequest>'
      expect(result.to_xml.split("\n")[2]).to eq '  <PersonSSNIdentification>564356789</PersonSSNIdentification>'
      expect(result.to_xml.split("\n")[3]).to eq '  <PersonName>'
      expect(result.to_xml.split("\n")[4]).to eq '    <PersonGivenName>John</PersonGivenName>'
    end
  end
end