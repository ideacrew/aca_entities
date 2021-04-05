# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/person_name_contract'
require 'aca_entities/medicaid/contracts/identifying_information_contract'
require 'aca_entities/medicaid/contracts/address_contract'
require 'aca_entities/contracts/phone_contract'
require 'aca_entities/medicaid/contracts/preference_contract'
require 'aca_entities/medicaid/contracts/primary_contact_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::PrimaryContactContract, type: :model, dbclean: :after_each do
  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:required_params) do
    {  person_name: { first_name: 'ivl', last_name: 'test' },
       addresses:
           [{ address_type_code: 'home', street_name_1: '123', street_name_2: '', city_name: 'was', county_name: '', state_code: 'DC',
              zip_code: '12321', fixed_address_indicator: true }],
       phones: [{}],
       preferences: [{ contact_preference_Code: 'TextMessage' }] }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing person_name' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :person_name })
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(person_name: ['tt']))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be a hash')
      end
    end
  end
end
