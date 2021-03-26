# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/application_reference'

RSpec.describe ::AcaEntities::MagiMedicaid::ApplicationReference, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { hbx_id: '10001' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    context 'no params' do
      it 'should raise error' do
        expect { subject }.to raise_error(Dry::Struct::Error, /:hbx_id is missing/)
      end
    end

    context 'bad input values' do
      it 'should raise error' do
        expect { described_class.new(hbx_id: 100) }.to raise_error(Dry::Struct::Error, /has invalid type for :hbx_id/)
      end
    end
  end
end
