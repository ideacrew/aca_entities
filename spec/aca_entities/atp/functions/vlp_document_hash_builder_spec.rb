# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/atp/functions/vlp_document_hash_builder'

RSpec.describe AcaEntities::Atp::Functions::VlpDocumentHashBuilder do
  let(:builder) { described_class.new }
  let(:document) do
    {
      category_code: 'NaturalizationCertificate',
      document_person_ids: [
        {
          identification_category_text: 'Alien Number',
          identification_id: '123456789'
        }
      ],
      document_numbers: [
        {
          identification_id: '987654321'
        }
      ],
      expiration_date: {
        date: '2022-12-31'
      }
    }
  end

  describe '#call' do
    it 'returns a hash with updated document information' do
      result = builder.call(document)
      expect(result[:category_code]).to eq('Naturalization Certificate')
      expect(result[:alien_number]).to eq('123456789')
      expect(result[:naturalization_certificate]).to eq('987654321')
      expect(result[:expiration_date]).to eq('2022-12-31')
    end
  end

  describe '#update_subject' do
    it 'updates the category_code of the document' do
      result = builder.update_subject(document)
      expect(result[:category_code]).to eq('Naturalization Certificate')
    end
  end

  describe '#create_person_ids_hash' do
    it 'creates a hash of person ids from the document' do
      result = builder.create_person_ids_hash(document)
      expect(result[:alien_number]).to eq('123456789')
    end
  end

  describe '#create_document_number_hash' do
    it 'creates a hash with the document number' do
      update_subject = builder.update_subject(document)
      result = builder.create_document_number_hash(update_subject)
      expect(result[:naturalization_certificate]).to eq('987654321')
    end
  end

  describe '#collect_document_fields' do
    it 'collects various fields from the document' do
      update_subject = builder.update_subject(document)
      result = builder.collect_document_fields(update_subject)
      expect(result[:alien_number]).to eq('123456789')
      expect(result[:expiration_date]).to eq('2022-12-31')
    end
  end
end