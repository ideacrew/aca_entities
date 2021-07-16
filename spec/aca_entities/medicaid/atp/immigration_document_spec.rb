# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/immigration_document'

RSpec.describe ::AcaEntities::Medicaid::Atp::ImmigrationDocument do

  describe 'with valid arguments' do
    let(:input_params) do
      { expiration_date: { date: Date.today.next_year },
        document_numbers: [{ identification_id: '123456789' }],
        document_person_ids: [{ identification_id: 'a-person-id' }],
        same_name_indicator: false,
        category_code: 'I327',
        category_text: 'test' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end