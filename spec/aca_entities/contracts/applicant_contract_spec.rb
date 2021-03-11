# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/person_name_contract'
require 'aca_entities/contracts/address_contract'
require 'aca_entities/contracts/demographic_contract'
require 'aca_entities/contracts/identifying_information_contract'
require 'aca_entities/contracts/identifying_numbers_from_document_contract'
require 'aca_entities/contracts/citizenship_immigration_status_information_contract'
require 'aca_entities/contracts/immigration_document_contract'
require 'aca_entities/contracts/native_american_information_contract'
require 'aca_entities/contracts/employer_sponsored_insurance_information_contract'
require 'aca_entities/contracts/lowest_cost_plan_contract'
require 'aca_entities/contracts/current_income_contract'
require 'aca_entities/contracts/ssa_income_information_contract'
require 'aca_entities/contracts/ssa_information_contract'
require 'aca_entities/contracts/ssa_work_quarter_contract'
require 'aca_entities/contracts/medicaid_specific_information_contract'
require 'aca_entities/contracts/other_insurance_coverage_information_contract'
require 'aca_entities/contracts/other_insurance_detail_contract'
require 'aca_entities/contracts/person_description_identifier_contract'
require 'aca_entities/contracts/attestation_contract'
require 'aca_entities/contracts/dhs_save_contract'
require 'aca_entities/contracts/coverage_specific_information_contract'
require 'aca_entities/contracts/coverage_period_contract'
require 'aca_entities/contracts/relationship_contract'
require 'aca_entities/contracts/foster_care_contract'
require 'aca_entities/contracts/basis_for_outcome_contract'
require 'aca_entities/contracts/applicant_contract'

RSpec.describe AcaEntities::Contracts::ApplicantContract, type: :model, dbclean: :after_each do
  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:required_params) do
    { person_name: { first_name: 'ivl40', last_name: '41' },
      demographic: { dob: '1940-09-17', gender: 'Male' },
      citizenship_immigration_status_information: { us_citizen: true },
      native_american_information: { is_native_american_or_alaska_native: false } }
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
