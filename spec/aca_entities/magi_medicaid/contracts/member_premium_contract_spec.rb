# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::MemberPremiumContract,  dbclean: :after_each do
  context 'valid params' do
    let(:input_params) { { member_identifier: '95', monthly_premium: 329.17 } }

    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end

  context 'invalid params' do
    context 'no params' do
      it 'should return failure' do
        expect(subject.call({}).errors.to_h).to eq({ member_identifier: ['is missing'],
                                                     monthly_premium: ['is missing'] })
      end
    end

    context 'invalid value for monthly_premium' do
      let(:input_params) { { member_identifier: '95', monthly_premium: 'test' } }

      it 'should return failure' do
        expect(subject.call(input_params).errors.to_h).to eq({ monthly_premium: ['must be a decimal'] })
      end
    end
  end
end
