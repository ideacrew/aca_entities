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

  describe '.initialize' do
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

  describe '#<=>' do
    let(:contact1_attributes) { contact_params }
    let(:contact1) { described_class.new(contact1_attributes) }

    let(:contact2) { described_class.new(contact2_attributes) }

    context 'when comparing with an identical contact' do
      let(:contact2_attributes) { contact_params }

      it 'returns 0' do
        expect(contact1 <=> contact2).to eq(0)
      end
    end

    context 'when comparing with a contact with different attributes' do
      let(:contact2_attributes) { contact_params.merge(first_name: 'Jane') }

      it 'returns -1 or 1' do
        expect([-1, 1]).to include(contact1 <=> contact2)
      end
    end

    context 'when comparing with a contact with a lower sort order' do
      let(:contact2_attributes) { contact_params.merge(hbxid_c: '12044') }

      it 'returns 1' do
        expect(contact1 <=> contact2).to eq(1)
      end
    end

    context 'when comparing with a contact with a higher sort order' do
      let(:contact2_attributes) { contact_params.merge(hbxid_c: '12346') }

      it 'returns -1' do
        expect(contact1 <=> contact2).to eq(-1)
      end
    end
  end
end
