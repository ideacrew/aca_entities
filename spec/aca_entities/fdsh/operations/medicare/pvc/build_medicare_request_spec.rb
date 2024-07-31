# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::Pvc::Medicare::Operations::BuildMedicareRequest do

  let!(:applicant) do
    { :name =>
      { :first_name => "filing",
        :middle_name => nil,
        :last_name => "jointly",
        :name_sfx => nil,
        :name_pfx => nil },
      :identifying_information =>
      { :encrypted_ssn => "yobheUbYUK2Abfc6lrq37YQCsPgBL8lLkw==\n",
        :ssn => "518124854",
        :has_ssn => false },
      :demographic =>
      { :gender => "Male",
        :dob => Date.new(1988, 1, 1),
        :ethnicity => ["", "", "", "", "", "", ""],
        :race => nil,
        :is_veteran_or_active_military => false,
        :is_vets_spouse_or_child => false },
      :attestation =>
      { :is_incarcerated => false,
        :is_self_attested_disabled => false,
        :is_self_attested_blind => false,
        :is_self_attested_long_term_care => false },
      :is_primary_applicant => true,
      :native_american_information =>
      { :indian_tribe_member => false, :tribal_id => nil },
      :citizenship_immigration_status_information =>
      { :citizen_status => "us_citizen",
        :is_resident_post_092296 => false,
        :is_lawful_presence_self_attested => false },
      :is_consumer_role => true,
      :is_resident_role => false,
      :is_applying_coverage => true,
      :is_consent_applicant => false,
      :vlp_document => nil,
      :family_member_reference =>
      { :family_member_hbx_id => "163061945480778",
        :first_name => "filing",
        :last_name => "jointly",
        :person_hbx_id => "163061945480778",
        :is_primary_family_member => true },
      :person_hbx_id => "163061945480778",
      :is_required_to_file_taxes => true,
      :is_filing_as_head_of_household => false,
      :tax_filer_kind => "tax_filer",
      :is_joint_tax_filing => true,
      :is_claimed_as_tax_dependent => false,
      :claimed_as_tax_dependent_by => nil,
      :student =>
      { :is_student => false,
        :student_kind => nil,
        :student_school_kind => nil,
        :student_status_end_on => nil },
      :is_refugee => false,
      :is_trafficking_victim => false,
      :foster_care =>
      { :is_former_foster_care => false,
        :age_left_foster_care => nil,
        :foster_care_us_state => nil,
        :had_medicaid_during_foster_care => false },
      :pregnancy_information =>
      { :is_pregnant => false,
        :is_enrolled_on_medicaid => false,
        :is_post_partum_period => false,
        :expected_children_count => nil,
        :pregnancy_due_on => nil,
        :pregnancy_end_on => nil },
      :is_subject_to_five_year_bar => false,
      :is_five_year_bar_met => false,
      :is_forty_quarters => false,
      :is_ssn_applied => false,
      :non_ssn_apply_reason => nil,
      :moved_on_or_after_welfare_reformed_law => false,
      :is_currently_enrolled_in_health_plan => false,
      :has_daily_living_help => false,
      :need_help_paying_bills => false,
      :has_job_income => false,
      :has_self_employment_income => false,
      :has_unemployment_income => false,
      :has_other_income => false,
      :has_deductions => false,
      :has_enrolled_health_coverage => false,
      :has_eligible_health_coverage => false,
      :job_coverage_ended_in_past_3_months => false,
      :job_coverage_end_date => nil,
      :medicaid_and_chip =>
      { :not_eligible_in_last_90_days => false,
        :denied_on => nil,
        :ended_as_change_in_eligibility => false,
        :hh_income_or_size_changed => false,
        :medicaid_or_chip_coverage_end_date => nil,
        :ineligible_due_to_immigration_in_last_5_years => false,
        :immigration_status_changed_since_ineligibility => false },
      :other_health_service => { :has_received => false, :is_eligible => false },
      :addresses =>
      [{ :kind => "home",
         :address_1 => "dc",
         :address_2 => nil,
         :address_3 => nil,
         :city => "dc",
         :county => nil,
         :state => "DC",
         :zip => "22302",
         :country_name => nil }],
      :emails => [],
      :phones => [],
      :incomes => [],
      :benefits => [],
      :deductions => [],
      :is_medicare_eligible => false,
      :has_insurance => false,
      :has_state_health_benefit => false,
      :had_prior_insurance => false,
      :prior_insurance_end_date => nil,
      :age_of_applicant => 33,
      :is_self_attested_long_term_care => false,
      :hours_worked_per_week => 0,
      :is_temporarily_out_of_state => false,
      :is_claimed_as_dependent_by_non_applicant => false,
      :benchmark_premium =>
      { :health_only_lcsp_premiums => [], :health_only_slcsp_premiums => [] },
      :is_homeless => false,
      :mitc_income =>
      { :amount => 0,
        :taxable_interest => 0,
        :tax_exempt_interest => 0,
        :taxable_refunds => 0,
        :alimony => 0,
        :capital_gain_or_loss => 0,
        :pensions_and_annuities_taxable_amount => 0,
        :farm_income_or_loss => 0,
        :unemployment_compensation => 0,
        :other_income => 0,
        :magi_deductions => 0,
        :adjusted_gross_income => 0,
        :deductible_part_of_self_employment_tax => 0,
        :ira_deduction => 0,
        :student_loan_interest_deduction => 0,
        :tution_and_fees => 0,
        :other_magi_eligible_income => 0 },
      :mitc_relationships =>
      [{ :other_id => 1_630_619_455_508_168,
         :attest_primary_responsibility => "Y",
         :relationship_code => "02" },
       { :other_id => 1_630_619_455_896_266,
         :attest_primary_responsibility => "Y",
         :relationship_code => "03" }],
      :mitc_is_required_to_file_taxes => true,
      :income_evidence => nil,
      :esi_evidence => nil,
      :non_esi_evidence => nil,
      :local_mec_evidence => nil }
  end

  subject do
    result = AcaEntities::MagiMedicaid::Contracts::ApplicantContract.new.call(applicant)
    applicant_entity = AcaEntities::MagiMedicaid::Applicant.new(result.to_h)

    described_class.new.call(applicant_entity, 2021)
  end

  it 'is successful' do
    expect(subject.success?).to be_truthy
  end

  it 'should return a Hash' do
    expect(subject.value!).to be_a(Hash)
  end
end
