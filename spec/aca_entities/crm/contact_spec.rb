# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/crm/libraries/crm_library'

RSpec.describe ::AcaEntities::Crm::Contact do

  let(:email) { 'john.doe@example.com' }

  let(:phone) { '(123) 456-7890' }

  let(:contact_params) do
    {
      hbxid_c: '12345',
      first_name: 'John',
      last_name: 'Doe',
      phone_mobile: phone,
      email: email,
      birthdate: (Date.today - 10_000).to_s,
      relationship_c: 'Spouse'
    }
  end

  context 'with all valid values' do
    before do
      app_params_result = AcaEntities::Crm::Contracts::ContactContract.new.call(contact_params)
      @result = if app_params_result.failure?
                  app_params_result
                else
                  described_class.new(app_params_result.to_h)
                end
    end

    it 'should return account entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of account' do
      expect(@result.to_h.keys.sort).to eq(contact_params.keys.sort)
    end
  end
end
