# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/crm/libraries/crm_library'
require 'aca_entities/shared_contexts/sugar_crm_account_data'

RSpec.describe AcaEntities::Crm::Transformers::SugarAccountTo::Account do
  include_context 'sugar account and contacts'

  subject { described_class.new }

  let(:transformed_account) do
    {
      :hbxid_c => "1000610",
      :name => "Jane Test Doe",
      :email1 => "JaneDoe@gmail.com",
      :billing_address_street => "1 Test St",
      :billing_address_street_2: nil,
      :billing_address_street_3: nil,
      :billing_address_street4: nil,
      :billing_address_city => "Testing City",
      :billing_address_postalcode => "04055",
      :billing_address_state => "ME",
      :phone_office => "(999) 123-1234",
      rawssn_c: nil,
      :raw_ssn_c => "111111111",
      :dob_c => "1990-01-01",
      :contacts => [
        {
          :hbxid_c => "1000610",
          :first_name => "Jane",
          :last_name => "Doe",
          :phone_mobile => "(999) 123-1234",
          :email1 => "JaneDoe@gmail.com",
          :birthdate => "1990-01-01",
          :relationship_c => "Self"
        },
        {
          :hbxid_c => "1000643",
          :first_name => "John",
          :last_name => "Doe",
          :phone_mobile => "",
          :email1 => '',
          :birthdate => "1990-01-02",
          :relationship_c => "Spouse"
        },
        {
          :hbxid_c => "1000644",
          :first_name => "Child1",
          :last_name => "Testing",
          :phone_mobile => "",
          :email1 => '',
          :birthdate => "2003-01-01",
          :relationship_c => "Child"
        },
        {
          :hbxid_c => "1000645",
          :first_name => "Child2",
          :last_name => "Testing",
          :phone_mobile => "",
          :email1 => '',
          :birthdate => "2005-01-01",
          :relationship_c => "Child"
        },
        {
          :hbxid_c => "1000646",
          :first_name => "Child3",
          :last_name => "Doe",
          :phone_mobile => "",
          :email1 => '',
          :birthdate => "2017-01-01",
          :relationship_c => "Child"
        },
        {
          :hbxid_c => "1000647",
          :first_name => "Nineteen",
          :last_name => "Test",
          :phone_mobile => "",
          :email1 => '',
          :birthdate => "2003-01-01",
          :relationship_c => "Child"
        },
        {
          :hbxid_c => "1000648",
          :first_name => "Test",
          :last_name => "Baby",
          :phone_mobile => "",
          :email1 => '',
          :birthdate => "2019-10-16",
          :relationship_c => "Child"
        }
      ]
    }
  end

  describe '#call' do
    context 'when input is valid' do
      it 'transforms input params successfully' do
        result = subject.call(input_params)
        expect(result).to be_success
        expect(result.value!).to eq(transformed_account)
      end
    end

    context 'when input is invalid' do
      it 'fails to transform and returns an error message' do
        allow(subject).to receive(:transform_contacts).and_raise(StandardError.new('Transformation error'))
        result = subject.call(input_params)
        expect(result).to be_failure
        expect(result.failure).to eq('Unable to transform Sugar Account: Transformation error')
      end
    end
  end
end
