# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/person_name_contract'
require 'aca_entities/medicaid/contracts/address_contract'
require 'aca_entities/medicaid/contracts/demographic_contract'
require 'aca_entities/medicaid/contracts/identifying_information_contract'
require 'aca_entities/medicaid/contracts/identifying_numbers_from_document_contract'
require 'aca_entities/medicaid/contracts/citizenship_immigration_status_information_contract'
require 'aca_entities/medicaid/contracts/immigration_document_contract'
require 'aca_entities/medicaid/contracts/native_american_information_contract'
require 'aca_entities/medicaid/contracts/employer_sponsored_insurance_information_contract'
require 'aca_entities/medicaid/contracts/lowest_cost_plan_contract'
require 'aca_entities/medicaid/contracts/current_income_contract'
require 'aca_entities/medicaid/contracts/ssa_income_information_contract'
require 'aca_entities/medicaid/contracts/ssa_information_contract'
require 'aca_entities/medicaid/contracts/ssa_work_quarter_contract'
require 'aca_entities/medicaid/contracts/medicaid_specific_information_contract'
require 'aca_entities/medicaid/contracts/other_insurance_coverage_information_contract'
require 'aca_entities/medicaid/contracts/other_insurance_detail_contract'
require 'aca_entities/medicaid/contracts/person_description_identifier_contract'
require 'aca_entities/medicaid/contracts/attestation_contract'
require 'aca_entities/medicaid/contracts/dhs_save_contract'
require 'aca_entities/medicaid/contracts/coverage_specific_information_contract'
require 'aca_entities/medicaid/contracts/coverage_period_contract'
require 'aca_entities/medicaid/contracts/relationship_contract'
require 'aca_entities/medicaid/contracts/foster_care_contract'
require 'aca_entities/medicaid/contracts/basis_for_outcome_contract'
require 'aca_entities/medicaid/contracts/applicant_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::ApplicantContract, type: :model, dbclean: :after_each do
  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:required_params) do
    { person_name: { given: 'ivl40', sur: '41' },
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
