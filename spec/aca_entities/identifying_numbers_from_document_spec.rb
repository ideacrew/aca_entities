# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/identifying_numbers_from_document'

RSpec.describe ::AcaEntities::IdentifyingNumbersFromDocument do

  describe 'with valid arguments' do
    let(:input_params) do
      { identifying_number: '123456789',
        identifying_number_type: 'Certificate of Citizenship',
        foreign_passport_country_of_issuance_code: 'USA' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
