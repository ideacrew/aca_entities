# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::NativeAmericanInformationContract,  dbclean: :after_each do
  context 'valid params' do
    let(:input_params) do
      { indian_tribe_member: true,
        tribal_id: '123456789',
        tribal_name: 'Tribal Name',
        tribal_state: 'VA' }
    end

    it 'should return success' do
      expect(subject.call(input_params)).to be_success
    end
  end
end
