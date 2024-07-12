# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::ApplicationReference do

  describe 'with valid arguments' do
    let(:input_params) do
      { hbx_id: '10001' }
    end

    before do
      appl_ref_params = AcaEntities::MagiMedicaid::Contracts::ApplicationReferenceContract.new.call(input_params).to_h
      @result = described_class.new(appl_ref_params)
    end

    it 'should return application_reference entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of application_reference' do
      expect(@result.to_h.keys).to eq(input_params.keys)
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
