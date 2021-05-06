# frozen_string_literal: true

RSpec.shared_context 'setup magi_medicaid application with two applicants', :shared_context => :metadata do
  let(:name) { { first_name: 'first', last_name: 'last' } }
  let(:name2) { { first_name: 'spouse', last_name: 'last' } }
  let(:identifying_information) { { has_ssn: false } }
  let(:demographic) do
    { gender: 'Male',
      dob: Date.today.prev_year.to_s,
      is_veteran_or_active_military: false }
  end
  let(:attestation) do
    { is_disabled: false,
      is_self_attested_blind: false,
      is_self_attested_disabled: true,
      is_incarcerated: false }
  end
  let(:family_member_reference) do
    { family_member_hbx_id: '1000',
      first_name: name[:first_name],
      last_name: name[:last_name],
      person_hbx_id: '95',
      is_primary_family_member: true }
  end
  let(:family_member2_reference) do
    { family_member_hbx_id: '1001',
      first_name: name2[:first_name],
      last_name: name2[:last_name],
      person_hbx_id: '96',
      is_primary_family_member: false }
  end
  let(:pregnancy_information) do
    { is_pregnant: false,
      is_post_partum_period: false,
      expected_children_count: nil }
  end
  let(:student) do
    { is_student: true,
      student_kind: 'graduate_school',
      student_school_kind: 'graduate_school',
      student_status_end_on: nil }
  end
  let(:foster_care) do
    { is_former_foster_care: true,
      age_left_foster_care: 10,
      foster_care_us_state: 'MA',
      had_medicaid_during_foster_care: false }
  end
  let(:address1) do
    { has_fixed_address: true,
      kind: 'home',
      address_1: '1234',
      address_3: 'person',
      city: 'test',
      county: '',
      county_name: '',
      state: 'DC',
      zip: '12345',
      country_name: 'USA',
      validation_status: 'ValidMatch',
      lives_outside_state_temporarily: false,
      start_on: Date.today.to_s,
      end_on: nil }
  end
  let(:address2) do
    { has_fixed_address: true,
      kind: 'mailing',
      address_1: '1234',
      address_3: 'person',
      city: 'test',
      county: '',
      county_name: '',
      state: 'DC',
      zip: '12345',
      country_name: 'USA',
      validation_status: 'ValidMatch',
      lives_outside_state_temporarily: true,
      start_on: Date.today.to_s,
      end_on: nil }
  end
  let(:addresses) do
    [address1, address2]
  end

  let(:mitc_income) do
    { amount: 300,
      taxable_interest: 30,
      tax_exempt_interest: 0,
      taxable_refunds: 1,
      alimony: 0,
      capital_gain_or_loss: 0,
      pensions_and_annuities_taxable_amount: 0,
      farm_income_or_loss: 0,
      unemployment_compensation: 0,
      other_income: 0,
      magi_deductions: 0,
      adjusted_gross_income: 300,
      deductible_part_of_self_employment_tax: 0,
      ira_deduction: 1,
      student_loan_interest_deduction: 9,
      tution_and_fees: 10,
      other_magi_eligible_income: 0 }
  end

  let(:applicant1_mitc_relationships) do
    [{ other_id: '95', attest_primary_responsibility: 'Y', relationship_code: '01' },
     { other_id: '96', attest_primary_responsibility: 'Y', relationship_code: '02' }]
  end
  let(:applicant_hash) do
    { name: name,
      identifying_information: identifying_information,
      citizenship_immigration_status_information: { citizen_status: 'us_citizen', is_lawful_presence_self_attested: false },
      demographic: demographic,
      attestation: attestation,
      is_primary_applicant: true,
      is_applying_coverage: false,
      family_member_reference: family_member_reference,
      person_hbx_id: '95',
      is_required_to_file_taxes: true,
      is_joint_tax_filing: false,
      is_claimed_as_tax_dependent: false,
      claimed_as_tax_dependent_by: nil,
      student: student,
      foster_care: foster_care,
      pregnancy_information: pregnancy_information,
      has_job_income: false,
      has_self_employment_income: false,
      has_unemployment_income: false,
      has_other_income: false,
      has_deductions: false,
      has_enrolled_health_coverage: false,
      has_eligible_health_coverage: false,
      is_medicare_eligible: false,
      is_self_attested_long_term_care: false,
      has_insurance: false,
      has_state_health_benefit: false,
      had_prior_insurance: false,
      age_of_applicant: 20,
      hours_worked_per_week: 0,
      is_subject_to_five_year_bar: false,
      is_five_year_bar_met: false,
      is_trafficking_victim: false,
      is_refugee: false,
      addresses: addresses,
      is_temporarily_out_of_state: false,
      is_claimed_as_dependent_by_non_applicant: false,
      mitc_relationships: applicant1_mitc_relationships,
      mitc_income: mitc_income }
  end

  let(:applicant2_mitc_relationships) do
    [{ other_id: '96', attest_primary_responsibility: 'N', relationship_code: '01' },
     { other_id: '95', attest_primary_responsibility: 'N', relationship_code: '02' }]
  end
  let(:applicant2_hash) do
    { name: name2,
      identifying_information: identifying_information,
      citizenship_immigration_status_information: { citizen_status: 'us_citizen', is_lawful_presence_self_attested: false },
      demographic: demographic,
      attestation: attestation,
      is_primary_applicant: true,
      is_applying_coverage: false,
      family_member_reference: family_member2_reference,
      person_hbx_id: '96',
      is_required_to_file_taxes: true,
      is_joint_tax_filing: true,
      is_claimed_as_tax_dependent: false,
      claimed_as_tax_dependent_by: applicant_reference,
      student: student,
      foster_care: foster_care,
      pregnancy_information: pregnancy_information,
      has_job_income: false,
      has_self_employment_income: false,
      has_unemployment_income: false,
      has_other_income: false,
      has_deductions: false,
      has_enrolled_health_coverage: false,
      has_eligible_health_coverage: false,
      is_medicare_eligible: false,
      is_self_attested_long_term_care: false,
      has_insurance: false,
      has_state_health_benefit: false,
      had_prior_insurance: false,
      age_of_applicant: 20,
      hours_worked_per_week: 0,
      is_subject_to_five_year_bar: false,
      is_five_year_bar_met: false,
      is_trafficking_victim: false,
      is_refugee: false,
      addresses: addresses,
      is_temporarily_out_of_state: false,
      is_claimed_as_dependent_by_non_applicant: false,
      mitc_relationships: applicant2_mitc_relationships,
      mitc_income: mitc_income }
  end
  let(:family_reference) { { hbx_id: '10011' } }

  let(:applicant_reference) do
    { first_name: applicant_hash[:name][:first_name],
      last_name: applicant_hash[:name][:last_name],
      dob: applicant_hash[:demographic][:dob],
      person_hbx_id: applicant_hash[:person_hbx_id] }
  end

  let(:applicant2_reference) do
    { first_name: applicant2_hash[:name][:first_name],
      last_name: applicant2_hash[:name][:last_name],
      dob: applicant2_hash[:demographic][:dob],
      person_hbx_id: applicant2_hash[:person_hbx_id] }
  end

  let(:product_eligibility_determination) do
    { is_ia_eligible: true,
      is_medicaid_chip_eligible: false,
      is_non_magi_medicaid_eligible: false,
      is_totally_ineligible: false,
      is_without_assistance: false,
      is_magi_medicaid: false,
      magi_medicaid_monthly_household_income: 6474.42,
      medicaid_household_size: 1,
      magi_medicaid_monthly_income_limit: 3760.67,
      magi_as_percentage_of_fpl: 10.0,
      magi_medicaid_category: 'parent_caretaker' }
  end

  let(:tax_household_member2) do
    { product_eligibility_determination: product_eligibility_determination,
      applicant_reference: applicant2_reference }
  end

  let(:product_eligibility_determination2) do
    { is_ia_eligible: true,
      is_medicaid_chip_eligible: false,
      is_non_magi_medicaid_eligible: false,
      is_totally_ineligible: false,
      is_without_assistance: false,
      is_magi_medicaid: false,
      magi_medicaid_monthly_household_income: 6474.42,
      medicaid_household_size: 1,
      magi_medicaid_monthly_income_limit: 3760.67,
      magi_as_percentage_of_fpl: 10.0,
      magi_medicaid_category: 'parent_caretaker' }
  end

  let(:tax_household_member) do
    { product_eligibility_determination: product_eligibility_determination,
      applicant_reference: applicant_reference }
  end

  let(:tax_household_member2) do
    { product_eligibility_determination: product_eligibility_determination2,
      applicant_reference: applicant2_reference }
  end

  let(:tax_hh) do
    { max_aptc: 100.56,
      csr: 73,
      is_insurance_assistance_eligible: 'Yes',
      tax_household_members: [tax_household_member, tax_household_member2] }
  end

  let(:iap_applicants) { [applicant_hash, applicant2_hash] }

  let(:person_references) do
    iap_applicants.collect { |appl| { person_id: appl[:family_member_reference][:person_hbx_id] } }
  end

  let(:mitc_households) do
    [{ household_id: '1',
       people: person_references }]
  end

  let(:tax_return_hash) do
    { filers: person_references, dependents: [] }
  end

  let(:iap_application) do
    { us_state: 'DC',
      hbx_id: '200000123',
      family_reference: family_reference,
      assistance_year: Date.today.year,
      applicants: iap_applicants,
      tax_households: [tax_hh],
      mitc_households: mitc_households,
      mitc_tax_returns: [tax_return_hash] }
  end
end