# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/attestation'

RSpec.describe ::AcaEntities::MagiMedicaid::Attestation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { is_incarcerated: false, is_disabled: false, is_self_attested_long_term_care: false }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(is_incarcerated: 'test') }.to raise_error(Dry::Struct::Error, /has invalid type for :is_incarcerated/)
    end
  end
end
