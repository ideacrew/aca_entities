# frozen_string_literal: true

RSpec.describe AcaEntities::BenefitMarkets::Products::PremiumValueProductContract do
  let(:contract) { described_class.new }

  let(:valid_params) do
    {
      product_id: '12345',
      rating_area_id: '67890',
      hios_id: '11111AA0001234',
      active_year: 2024
    }
  end

  describe '#call' do
    context 'when all required fields are provided' do
      it 'should return a success result' do
        result = contract.call(valid_params)
        expect(result.success?).to be_truthy
        expect(result.errors).to be_empty
      end
    end

    context 'when required fields are missing' do
      it 'should return a failure with errors' do
        invalid_params = valid_params.except(:product_id)
        result = contract.call(invalid_params)
        expect(result.success?).to be_falsey
        expect(result.errors.to_h).to include(:product_id)
      end
    end

    context 'when fields have invalid types' do
      it 'should return a failure with errors' do
        invalid_params = valid_params.merge(active_year: 'twenty twenty-four')
        result = contract.call(invalid_params)
        expect(result.success?).to be_falsey
        expect(result.errors.to_h).to include(:active_year)
      end
    end
  end
end
