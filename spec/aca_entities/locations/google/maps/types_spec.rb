# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Locations::Google::Maps::Types do
  subject(:type) { AcaEntities::Locations::Google::Maps::Types::LatitudeKind }

  context 'LattitudeKind' do
    context 'given argument is an in-range Integer' do
      let(:valid_decimal_latitude) { -90.0 }

      it 'should coerce to a decimal value' do
        expect(type[valid_decimal_latitude]).to be_truthy
        expect(type[valid_decimal_latitude]).to eq valid_decimal_latitude
      end
    end

    context 'given argument is less than min range value' do
      let(:invalid_min_latitude) { -91 }

      it 'validation should fail' do
        expect { type[invalid_min_latitude] }.to raise_error Dry::Types::ConstraintError
      end
    end

    context 'given argument is greater than max range value' do
      let(:invalid_max_latitude) { 91 }

      it 'validation should fail' do
        expect { type[invalid_max_latitude] }.to raise_error Dry::Types::ConstraintError
      end
    end

    context 'given arugment is inside valid range' do
      let(:valid_min_latitude) { -90.0 }

      it 'validation should succeed' do
        expect(type[valid_min_latitude]).to eq valid_min_latitude
      end
    end
  end
end
