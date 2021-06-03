# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::OtherHealthService, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { has_received: true,
        is_eligible: false }
    end

    before do
      medicaid_cubcare_params = AcaEntities::MagiMedicaid::Contracts::OtherHealthServiceContract.new.call(input_params).to_h
      @result = described_class.new(medicaid_cubcare_params)
    end

    it 'should return OtherHealthService entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of OtherHealthService' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end
end
