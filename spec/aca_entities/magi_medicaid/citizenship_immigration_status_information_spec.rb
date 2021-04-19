# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::CitizenshipImmigrationStatusInformation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { citizen_status: 'us_citizen' }
    end

    before do
      cisi_params = AcaEntities::MagiMedicaid::Contracts::CitizenshipImmigrationStatusInformationContract.new.call(input_params).to_h
      @result = described_class.new(cisi_params)
    end

    it 'should return CitizenshipImmigrationStatusInformation entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of CitizenshipImmigrationStatusInformation' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:citizen_status is missing/)
    end
  end
end
