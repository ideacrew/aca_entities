# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mec_check'

RSpec.describe AcaEntities::Medicaid::MecCheck::Operations::GenerateXml  do
  describe 'When a valid json file is passed' do

    let(:payload) { File.read(Pathname.pwd.join("spec/support/mec_check/person_json.json")) }

    it 'should parse and then transform' do
      result = described_class.new.call(payload)

      expect(result.success?).to be_truthy
    end

    context 'request for get eligiblity' do
      let(:payload) { File.read(Pathname.pwd.join("spec/support/mec_check/get_eligibility_for_person.json")) }

      it 'should parse and then transform' do
        result = described_class.new.call(payload)
        expect(result.success?).to be_truthy
      end
    end
  end
end