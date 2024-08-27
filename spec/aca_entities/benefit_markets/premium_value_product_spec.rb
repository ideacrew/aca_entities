# frozen_string_literal: true

RSpec.describe AcaEntities::BenefitMarkets::PremiumValueProduct do
  let(:valid_params) do
    {
      hios_id: '12345AA0001234',
      active_year: 2024,
      product_id: 'prod-001',
      rating_area_id: 'RA-001'
    }
  end

  describe 'attributes' do
    subject { described_class.new(valid_params) }

    it 'should have the correct hios_id' do
      expect(subject.hios_id).to eq('12345AA0001234')
    end

    it 'should have the correct active_year' do
      expect(subject.active_year).to eq(2024)
    end

    it 'should have the correct product_id' do
      expect(subject.product_id).to eq('prod-001')
    end

    it 'should have the correct rating_area_id' do
      expect(subject.rating_area_id).to eq('RA-001')
    end
  end

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid' do
        expect(described_class.new(valid_params)).to be_a described_class
      end
    end

    context 'with missing attributes' do
      it 'raises an error when hios_id is missing' do
        invalid_params = valid_params.except(:hios_id)
        expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /:hios_id is missing/)
      end

      it 'raises an error when active_year is missing' do
        invalid_params = valid_params.except(:active_year)
        expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /:active_year is missing/)
      end

      it 'raises an error when product_id is missing' do
        invalid_params = valid_params.except(:product_id)
        expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /:product_id is missing/)
      end

      it 'raises an error when rating_area_id is missing' do
        invalid_params = valid_params.except(:rating_area_id)
        expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /:rating_area_id is missing/)
      end
    end

    context 'with incorrect data types' do
      it 'raises an error when active_year is not an integer' do
        invalid_params = valid_params.merge(active_year: 'twenty twenty-four')
        expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /invalid type for :active_year/)
      end

      it 'raises an error when hios_id is not a string' do
        invalid_params = valid_params.merge(hios_id: 123)
        expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /invalid type for :hios_id/)
      end
    end
  end
end
