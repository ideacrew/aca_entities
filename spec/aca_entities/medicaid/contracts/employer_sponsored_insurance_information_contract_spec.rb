# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/employer_sponsored_insurance_information_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::EmployerSponsoredInsuranceInformationContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    { employer_ein: '123456789',
      employer_name: 'Employer ABC',
      is_a_cobra_coverage: false,
      employee_status_code: 'CurrentlyEmployed',
      changes_esi_status: false,
      retiree_plan_coverage: false,
      lcsop_coverage_code: 'Offers',
      lcsop_end_date: Date.today,
      lcsop_cost_code: 'Offers',
      lcsop_cost_change_date: Date.today,
      new_lcsop_premium: 100.00,
      is_employer_active: true,
      date_employer_drops_lcsop: Date.today,
      employee_do_not_know_lcsop_cost: false,
      employee_do_not_know_offered_coverage: false,
      employee_will_drop_coverage_code: 'Enrolled',
      employee_plans_to_enroll_in_esi: true,
      esi_coverage_start_date: Date.today,
      esi_coverage_end_date: Date.today.next_year,
      is_offered: false,
      is_enrolled: true,
      eligible_to_enroll_date: Date.today }
  end

  context 'success case' do
    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'invalid input for employee_status_code' do
      before do
        @result = subject.call(input_params.merge(employee_status_code: 'Test'))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        msg = 'must be one of: NoLongerEmployed, Retired, CurrentlyEmployed'
        expect(@result.errors.messages.first.text).to eq(msg)
      end
    end

    context 'invalid input for employer_ein' do
      before do
        @result = subject.call(input_params.merge(employer_ein: '1234'))
      end

      it 'should return error message as start date' do
        error_message = 'Employer Identification Number should be numbers of size 9.'
        expect(@result.errors.messages.first.text).to eq(error_message)
      end
    end
  end
end
