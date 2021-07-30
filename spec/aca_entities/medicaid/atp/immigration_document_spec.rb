# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/document_expiration_date'
require 'aca_entities/medicaid/atp/document_number'
require 'aca_entities/medicaid/atp/document_person_identification'
require 'aca_entities/medicaid/atp/immigration_document'

RSpec.describe ::AcaEntities::Medicaid::Atp::ImmigrationDocument do

  describe 'with valid arguments' do

    let(:required_params) { {} }

    let(:optional_params) do
      {
        expiration_date: { date: Date.today.next_year },
        document_numbers: [{ identification_id: '123456789' }],
        document_person_ids: [{ identification_id: 'a-person-id' }],
        same_name_indicator: false,
        category_code: 'I327',
        category_text: 'test'
      }
    end

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end

    context 'with only optional parameters' do
      it 'should contain all optional keys and values' do
        result = described_class.new(optional_params)
        expect(result.to_h).to eq optional_params
      end
    end
  end
end