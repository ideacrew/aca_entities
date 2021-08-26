# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::BenchmarkPremium, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:member1_lcsp_premium) { { member_identifier: '95', monthly_premium: 310.50 } }
    let(:member2_lcsp_premium) { { member_identifier: '96', monthly_premium: 310.60 } }
    let(:member1_slcsp_premium) { { member_identifier: '95', monthly_premium: 320.50 } }
    let(:member2_slcsp_premium) { { member_identifier: '96', monthly_premium: 320.60 } }
    let(:input_params) do
      { health_only_lcsp_premiums: [member1_lcsp_premium, member2_lcsp_premium],
        health_only_slcsp_premiums: [member1_slcsp_premium, member2_slcsp_premium] }
    end

    before do
      mp_params = AcaEntities::MagiMedicaid::Contracts::BenchmarkPremiumContract.new.call(input_params).to_h
      @result = described_class.new(mp_params)
    end

    it 'should return BenchmarkPremium entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of BenchmarkPremium' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end

    it 'should match all the input keys of lcsp_premiums' do
      result_lcsp_keys = @result.to_h[:health_only_lcsp_premiums][0].keys
      input_lcsp_keys = member1_lcsp_premium.keys
      expect(result_lcsp_keys - input_lcsp_keys).to be_empty
      expect(input_lcsp_keys - result_lcsp_keys).to be_empty
    end

    it 'should match all the input keys of health_only_slcsp_premiums' do
      result_lcsp_keys = @result.to_h[:health_only_slcsp_premiums][1].keys
      input_lcsp_keys = member2_lcsp_premium.keys
      expect(result_lcsp_keys - input_lcsp_keys).to be_empty
      expect(input_lcsp_keys - result_lcsp_keys).to be_empty
    end

    it 'should match all the input keys of slcsp_premiums' do
      result_slcsp_keys = @result.to_h[:health_only_lcsp_premiums][0].keys
      input_slcsp_keys = member1_slcsp_premium.keys
      expect(result_slcsp_keys - input_slcsp_keys).to be_empty
      expect(input_slcsp_keys - result_slcsp_keys).to be_empty
    end

    it 'should match all the input keys of slcsp_premiums' do
      result_slcsp_keys = @result.to_h[:health_only_lcsp_premiums][1].keys
      input_slcsp_keys = member2_slcsp_premium.keys
      expect(result_slcsp_keys - input_slcsp_keys).to be_empty
      expect(input_slcsp_keys - result_slcsp_keys).to be_empty
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      msg = /invalid type for :health_only_lcsp_premiums violates constraints/
      expect { described_class.new(health_only_lcsp_premiums: 'Test') }.to raise_error(Dry::Struct::Error, msg)
    end
  end
end
