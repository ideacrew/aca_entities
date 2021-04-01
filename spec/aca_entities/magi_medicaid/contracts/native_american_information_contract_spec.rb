# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/contracts/native_american_information_contract'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::NativeAmericanInformationContract,  dbclean: :after_each do
  context 'valid params' do
    let(:input_params) { { indian_tribe_member: true, tribal_id: '123456789' } }

    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end

  context 'invalid params' do
    context 'invalid value for tribal_id' do
      let(:input_params) { { indian_tribe_member: true, tribal_id: ['12345', 'a2873'].sample } }

      it 'should return failure' do
        expect(subject.call(input_params).errors.to_h).to eq({ tribal_id: ['should be of length 9 and allows numbers only'] })
      end
    end
  end
end
