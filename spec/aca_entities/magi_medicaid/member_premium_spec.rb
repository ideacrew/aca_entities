# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::MemberPremium, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { member_identifier: '95', monthly_premium: 329.17 }
    end

    before do
      mp_params = AcaEntities::MagiMedicaid::Contracts::MemberPremiumContract.new.call(input_params).to_h
      @result = described_class.new(mp_params)
    end

    it 'should return MemberPremium entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of MemberPremium' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      msg = /invalid type for :monthly_premium violates constraints/
      expect { described_class.new(monthly_premium: 'Test') }.to raise_error(Dry::Struct::Error, msg)
    end
  end
end
