# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/role_of_person_reference'
require 'aca_entities/medicaid/atp/chip_trafficking_victim_category_eligibility_basis'
require 'aca_entities/medicaid/atp/chip_eligibility'
require 'aca_entities/medicaid/atp/lawful_presence_status_eligibility'
require 'aca_entities/medicaid/atp/insurance_applicant_lawful_presence_status'
require 'aca_entities/medicaid/atp/insurance_applicant'

RSpec.describe ::AcaEntities::Medicaid::Atp::InsuranceApplicant, dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) do
      { role_reference: { ref: "a-person-id" },
        fixed_address_indicator: true }
    end

    let(:optional_params) do
      { esi_eligible_indicator: false,
        non_esi_coverage_indicators: [false],
        age_left_foster_care: 14,
        foster_care_state: "n/a",
        blindness_or_disability_indicator: false,
        had_medicaid_during_foster_care_indicator: false,
        lawful_presence_status:
          { arrived_before_1996_indicator: false,
            lawful_presence_status_eligibility: { eligibility_indicator: false } },
        long_term_care_indicator: false,
        temporarily_lives_outside_application_state_indicator: false,
        foster_care_indicator: false,
        chip_eligibilities: [{ status_indicator: false }] }
    end

    let(:all_params) { required_params.merge(optional_params) }

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:ref is missing in Hash input/)
    end
  end
end