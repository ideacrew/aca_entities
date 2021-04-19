# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/person_name'
require 'aca_entities/medicaid/atp/identifying_information'
require 'aca_entities/medicaid/atp/address'
require 'aca_entities/contacts/phone_contact'
require 'aca_entities/medicaid/atp/preference'
require 'aca_entities/medicaid/atp/primary_contact'

RSpec.describe ::AcaEntities::Medicaid::Atp::PrimaryContact, dbclean: :after_each do
  let(:required_params) do
    {  person_name: { first_name: 'ivl', last_name: 'test' },
       addresses:
           [{ address_type_code: 'home', street_name_1: '123', street_name_2: '', city_name: 'was', county_name: '', state_code: 'DC',
              zip_code: '12321', fixed_address_indicator: true }],
       phones: [],
       preference: [] }
  end

  context 'invalid params' do
    context 'with empty params' do
      it 'should raise error' do
        expect {subject}.to raise_error(Dry::Struct::Error, /:first_name is missing in Hash input/)
      end
    end
  end

  context 'valid params' do
    context 'required params only' do
      it { expect(described_class.new(required_params).to_h).to eq required_params }
    end
  end
end
