# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/person_name_contract'
require 'aca_entities/medicaid/contracts/identifying_information_contract'
require 'aca_entities/medicaid/contracts/demographic_contract'
require 'aca_entities/medicaid/contracts/pregnancy_information_contract'
require 'aca_entities/medicaid/contracts/current_income_information_contract'
require 'aca_entities/medicaid/contracts/current_deduction_information_contract'
require 'aca_entities/medicaid/contracts/current_income_contract'
require 'aca_entities/medicaid/contracts/current_income_employer_contract'
require 'aca_entities/medicaid/contracts/pay_period_information_contract'
require 'aca_entities/medicaid/contracts/relationship_contract'
require 'aca_entities/medicaid/contracts/household_member_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::HouseholdMemberContract, type: :model, dbclean: :after_each do
  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:required_params) do
    { person_name: { first_name: 'ivl40', last_name: '41' },
      demographic: { dob: Date.new(2000, 1, 1), gender: 'Male' },
      relationships: [{ is_member_of_applicants_medicaid_household: false }] }
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
