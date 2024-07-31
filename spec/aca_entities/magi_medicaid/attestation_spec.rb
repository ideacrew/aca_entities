# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Attestation do

  describe 'with valid arguments' do
    let(:input_params) do
      { is_incarcerated: false, is_self_attested_disabled: false, is_self_attested_long_term_care: false }
    end

    before do
      att_params = AcaEntities::MagiMedicaid::Contracts::AttestationContract.new.call(input_params).to_h
      @result = described_class.new(att_params)
    end

    it 'should return attestation entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of attestation' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(is_incarcerated: 'test') }.to raise_error(Dry::Struct::Error, /has invalid type for :is_incarcerated/)
    end
  end
end
