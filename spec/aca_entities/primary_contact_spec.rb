# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/person_name'
require 'aca_entities/identifying_information'
require 'aca_entities/address'
require 'aca_entities/phone'
require 'aca_entities/preference'
require 'aca_entities/primary_contact'

RSpec.describe ::AcaEntities::PrimaryContact, dbclean: :after_each do
  let(:required_params) do
    {  person_name: { first_name: 'ivl', last_name: 'test' },
       addresses:
           [{ kind: 'home', address_1: '123', address_2: '', address_3: '', city: 'was', county: '', state: 'DC',
              zip: '12321', country_name: '', has_fixed_address: true }],
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
      it {expect(described_class.new(required_params).to_h).to eq required_params}
    end
  end
end
