# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::IdentifyingInformation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { has_ssn: false }
    end

    before do
      ii_params = AcaEntities::MagiMedicaid::Contracts::IdentifyingInformationContract.new.call(input_params).to_h
      @result = described_class.new(ii_params)
    end

    it 'should return IdentifyingInformation entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of IdentifyingInformation' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:has_ssn is missing/)
    end
  end
end
