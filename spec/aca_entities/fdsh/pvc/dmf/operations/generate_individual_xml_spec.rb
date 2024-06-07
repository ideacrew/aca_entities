# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/fdsh/pvc/dmf/operations/generate_individual_xml'

RSpec.describe AcaEntities::Fdsh::Pvc::Dmf::Operations::GenerateIndividualXml do
  describe 'valid attributes' do
    let(:required_params) do
      { IndividualRequests: [{ :PersonName => { :PersonGivenName => "test", :PersonSurName => "test" },
                               :PersonSSNIdentification => { :SSNIdentification => "123456789" },
                               :PersonBirthDate => Date.today }] }
    end

    it 'should generate xml' do
      expect { described_class.new.call(required_params) }.not_to raise_error
    end

    it 'should match attributes' do
      result = described_class.new.call(required_params).success
      expect(result).to match(/<ext:IndividualRequest>/)
      expect(result).to match(/<nc:PersonName>/)
      expect(result).to match(%r{<nc:PersonGivenName>test</nc:PersonGivenName>})
    end
  end

  describe 'invalid attributes' do
    let(:required_params) do
      { PersonName: { PersonGivenName: "test", PersonSurName: nil }, PersonSSNIdentification: "123456789", PersonBirthDate: Date.today }
    end

    it 'should not generate xml' do
      expect { described_class.new(required_params) }.to raise_error
    end
  end
end