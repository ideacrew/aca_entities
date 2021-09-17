# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mec_check'
require 'pry'

RSpec.describe AcaEntities::Medicaid::MecCheck::Operations::GenerateXml  do
  describe 'When a valid json file is passed' do

    let(:payload) { File.read(Pathname.pwd.join("spec/support/mec_check/person_json.json")) }

    it 'should parse and then transform' do
      result = described_class.new.call(payload)
      # _example_output_xml = File.read(Pathname.pwd.join('spec/support/atp/sample_payloads/simple_L_transformed_payload.xml'))

      expect(result.success?).to be_truthy
    end
  end
end