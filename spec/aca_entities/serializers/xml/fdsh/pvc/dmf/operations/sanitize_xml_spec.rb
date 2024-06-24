# frozen_string_literal: true

# lib/aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_name.rb

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/pvc'

# AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Operations::SanitizeXML.new.call(xml_string)
RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Operations::SanitizeXML do
  let(:xml_string) { File.read(file_path)}

  context 'with valid arguments' do
    let(:file_path) { "spec/support/dmf_test_payloads/PVC_DMF_valid_Response_1.xml" }
    before do
      @result = described_class.new.call(xml_string)
    end

    it 'returns success' do
      expect(@result.success?).to be_truthy
    end

    it 'returns a string' do
      expect(@result.value!).to be_a String
    end

    it 'returns a string without xml node' do
      expect(@result.value!).not_to include("<?xml version=\"1.0\"?>")
    end

  end

  context 'with invalid arguments' do
    let(:file_path) { "spec/support/dmf_test_payloads/PVC_DMF_invalid_Response_1.xml" }

    before do
      @result = described_class.new.call(xml_string)
    end

    it 'returns failure' do
      expect(@result.success?).to be_truthy
    end

    it 'returns a string' do
      expect(@result.value!).to be_a String
    end

    it 'returns a string without xml node' do
      expect(@result.value!).not_to include("<?xml version=\"1.0\"?>")
    end
  end
end