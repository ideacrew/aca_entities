# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Operations::CreatePerson do

  context 'valid params' do
    let(:valid_params) do
      {
        person_name: { first_name: 'John', last_name: 'Smith' },
        hbx_id: '123456',
        person_health: {},
        is_active: true,
        person_demographics: { encrypted_ssn: '1234567', gender: 'Male', dob: "1985-01-01" }
      }
    end

    let(:response) {described_class.new.call(valid_params)  }
    it 'returns success' do
      expect(response).to be_success
    end

    it 'returns an instance of AcaEntities::People::Person' do
      expect(response.success).to be_a(::AcaEntities::People::Person)
    end
  end

  context 'invalid params' do
    let(:invalid_params) do
      {
        hbx_id: '123456',
        person_health: {},
        is_active: true,
        person_demographics: { encrypted_ssn: '1234567', gender: 'Male', dob: "1985-01-01" }
      }
    end

    let(:response) {described_class.new.call(invalid_params) }
    it 'returns failure' do
      expect(response).to be_failure
    end

    it 'returns failure with error messages' do
      expect(response.failure).to eq({ person_name: ['is missing'] })
    end
  end
end
