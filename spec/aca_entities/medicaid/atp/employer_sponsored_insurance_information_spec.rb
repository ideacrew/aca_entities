# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/employer_sponsored_insurance_information'

RSpec.describe ::AcaEntities::Medicaid::Atp::EmployerSponsoredInsuranceInformation do

  describe 'with valid arguments' do
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

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
