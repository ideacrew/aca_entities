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

  let(:naturalization_certificate_2) do
    {
      category_code: 'NaturalizationCertificate',
      document_person_ids: [
        {
          identification_category_text: 'Alien Number',
          identification_id: '123456789'
        },
        {
          identification_category_text: 'Naturalization Certificate Number',
          identification_id: '123456789'
        }
      ],
      expiration_date: {
        date: '2022-12-31'
      }
    }
  end

  let(:document_citizenship) do
    {
      category_code: 'Certificate of Citizenship',
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

  let(:document_citizenship_2) do
    {
      category_code: 'Certificate of Citizenship',
      document_person_ids: [
        {
          identification_category_text: 'Alien Number',
          identification_id: '123456789'
        },
        {
          identification_category_text: 'certificate of citizenship',
          identification_id: '123456789'
        }
      ],
      expiration_date: {
        date: '2022-12-31'
      }
    }
  end

  let(:document_i551) do
    {
      category_code: 'I551',
      document_person_ids: [
        {
          identification_category_text: 'Alien Number',
          identification_id: '123456789'
        }
      ],
      document_numbers: [
        {
          identification_id: 'AAA0000000000'
        }
      ],
      expiration_date: {
        date: '2022-12-31'
      }
    }
  end

  describe '#call' do
    context 'with a document that is a naturalization certificate' do
      it 'returns a hash with updated document information' do
        result = builder.call(document)
        expect(result[:category_code]).to eq('Naturalization Certificate')
        expect(result[:alien_number]).to eq('123456789')
        expect(result[:naturalization_certificate]).to eq('987654321')
        expect(result[:naturalization_number]).to eq('987654321')
        expect(result[:expiration_date]).to eq('2022-12-31')
        expect(result[:card_number]).to be_nil
      end
    end

    context 'with a document person id that is a naturalization certificate' do
      it 'returns a hash with updated document information' do
        result = builder.call(naturalization_certificate_2)
        expect(result[:category_code]).to eq('Naturalization Certificate')
        expect(result[:alien_number]).to eq('123456789')
        expect(result[:naturalization_number]).to eq('123456789')
        expect(result[:expiration_date]).to eq('2022-12-31')
        expect(result[:card_number]).to be_nil
      end
    end

    context 'with a document person id that is a certificate of citizenship' do
      it 'returns a hash with updated document information' do
        result = builder.call(document_citizenship_2)
        expect(result[:category_code]).to eq('Certificate of Citizenship')
        expect(result[:alien_number]).to eq('123456789')
        expect(result[:citizenship_number]).to eq('123456789')
        expect(result[:expiration_date]).to eq('2022-12-31')
        expect(result[:card_number]).to be_nil
      end
    end

    context 'with a document that is a citizenship certificate' do
      it 'returns a hash with updated document information' do
        result = builder.call(document_citizenship)
        expect(result[:category_code]).to eq('Certificate of Citizenship')
        expect(result[:alien_number]).to eq('123456789')
        expect(result[:citizenship_number]).to eq('987654321')
        expect(result[:expiration_date]).to eq('2022-12-31')
        expect(result[:card_number]).to be_nil
        expect(result[:naturalization_certificate]).to be_nil
      end
    end

    context 'with a document that is an I-551' do
      it 'returns a hash with updated document information' do
        result = builder.call(document_i551)
        expect(result[:category_code]).to eq('I-551 (Permanent Resident Card)')
        expect(result[:alien_number]).to eq('123456789')
        expect(result[:expiration_date]).to eq('2022-12-31')
        expect(result[:card_number]).to eq('AAA0000000000')
      end
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