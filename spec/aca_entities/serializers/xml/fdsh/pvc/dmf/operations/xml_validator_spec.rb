# frozen_string_literal: true

# lib/aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_name.rb

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/pvc'

# AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Operations::XMLValidator.new.call(xml_string, schema_file_path)
RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Pvc::Dmf::Operations::XMLValidator do
  let(:schema_file_path) { "/fdsh/pvc/dmf/response/schemas/main/XMLschemas/constraint/XMLschemas/exchange/ExchangeModel.xsd" }
  let(:xml_string) { File.read(file_path)}

  context 'with valid arguments' do
    let(:file_path) { "spec/support/dmf_test_payloads/PVC_DMF_valid_Response_1.xml" }

    before do
      @result = described_class.new.call(xml_string, schema_file_path)
    end

    it 'returns success' do
      expect(@result.success?).to be_truthy
    end
  end

  context 'with invalid arguments' do
    let(:file_path) { "spec/support/dmf_test_payloads/PVC_DMF_invalid_Response_1.xml" }

    before do
      @result = described_class.new.call(xml_string, schema_file_path)
    end

    it 'returns failure' do
      expect(@result.success?).to be_falsey
    end
  end
end