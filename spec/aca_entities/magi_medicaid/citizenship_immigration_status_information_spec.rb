# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::CitizenshipImmigrationStatusInformation do

  describe 'with valid arguments' do
    let(:input_params) do
      { citizen_status: 'us_citizen', is_lawful_presence_self_attested: false }
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
end
