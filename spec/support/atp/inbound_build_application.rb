# frozen_string_literal: true

RSpec.shared_context "inbound_build_application" do
  let(:context) do
    # rubocop:disable Layout/LineLength
    context_hash = { "external_id" => { :name => "external_id", :item => "IDC1000886" },
                     "insurance_application.insurance_applicants" => { :name => "insurance_application.insurance_applicants", :item => { :IDC1003158 => { :id => "IDC1003158", :role_reference => { :ref => "IDC1003158" }, :fixed_address_indicator => false, :incarcerations => [{ :incarceration_indicator => false, :incarceration_date => { :date => "", :date_time => "", :year => nil, :year_month => nil } }], :absent_parent_or_spouse_code => nil, :blindness_or_disability_indicator => nil, :coverage_during_previous_six_months_indicator => nil, :eligible_itu_services_indicator => nil, :lawful_presence_status => { :arrived_before_1996_indicator => nil, :immigration_documents => [], :lawful_presence_status_eligibility => { :eligibility_indicator => nil } }, :long_term_care_indicator => nil, :non_esi_coverage_indicators => [], :parent_caretaker_indicator => nil, :received_itu_services_indicator => nil, :recent_medical_bills_indicator => nil, :state_benefits_through_public_employee_indicator => nil, :student_indicator => nil, :esi_associations => [{ :eligible_indicator => true, :enrolled_indicator => nil, :planned_coverage_date_ranges => [], :eligibility_unknown_indicator => nil, :ref => nil }], :non_esi_policies => [], :emergency_medicaid_eligibilities => [], :medicaid_magi_eligibilities => [], :medicaid_non_magi_eligibilities => [], :aptc_eligibilities => [], :exchange_eligibilities => [], :csr_eligibilities => [], :chip_eligibilities => [], :temporarily_lives_outside_application_state_indicator => nil, :age_left_foster_care => nil, :foster_care_state => nil, :had_medicaid_during_foster_care_indicator => nil, :lives_with_minor_age_dependent_indicator => nil, :household_exception_indicator => nil, :referral_activity => nil, :foster_care_indicator => nil, :parent_average_hours_worked_per_week_values => nil }, :IDC1002699 => { :id => "IDC1002699", :role_reference => { :ref => "IDC1002699" }, :fixed_address_indicator => false, :incarcerations => [{ :incarceration_indicator => false, :incarceration_date => { :date => "", :date_time => "", :year => nil, :year_month => nil } }], :absent_parent_or_spouse_code => nil, :blindness_or_disability_indicator => nil, :coverage_during_previous_six_months_indicator => nil, :eligible_itu_services_indicator => nil, :lawful_presence_status => { :arrived_before_1996_indicator => nil, :immigration_documents => [], :lawful_presence_status_eligibility => { :eligibility_indicator => nil } }, :long_term_care_indicator => nil, :non_esi_coverage_indicators => [], :parent_caretaker_indicator => nil, :received_itu_services_indicator => nil, :recent_medical_bills_indicator => nil, :state_benefits_through_public_employee_indicator => nil, :student_indicator => nil, :esi_associations => [], :non_esi_policies => [], :emergency_medicaid_eligibilities => [], :medicaid_magi_eligibilities => [], :medicaid_non_magi_eligibilities => [], :aptc_eligibilities => [], :exchange_eligibilities => [], :csr_eligibilities => [], :chip_eligibilities => [], :temporarily_lives_outside_application_state_indicator => nil, :age_left_foster_care => nil, :foster_care_state => nil, :had_medicaid_during_foster_care_indicator => nil, :lives_with_minor_age_dependent_indicator => nil, :household_exception_indicator => nil, :referral_activity => nil, :foster_care_indicator => nil, :parent_average_hours_worked_per_week_values => nil }, :IDC1003159 => { :id => "IDC1003159", :role_reference => { :ref => "IDC1003159" }, :fixed_address_indicator => false, :incarcerations => [{ :incarceration_indicator => false, :incarceration_date => { :date => "", :date_time => "", :year => nil, :year_month => nil } }], :absent_parent_or_spouse_code => nil, :blindness_or_disability_indicator => nil, :coverage_during_previous_six_months_indicator => nil, :eligible_itu_services_indicator => nil, :lawful_presence_status => { :arrived_before_1996_indicator => nil, :immigration_documents => [], :lawful_presence_status_eligibility => { :eligibility_indicator => nil } }, :long_term_care_indicator => nil, :non_esi_coverage_indicators => [], :parent_caretaker_indicator => nil, :received_itu_services_indicator => nil, :recent_medical_bills_indicator => nil, :state_benefits_through_public_employee_indicator => nil, :student_indicator => nil, :esi_associations => [], :non_esi_policies => [], :emergency_medicaid_eligibilities => [], :medicaid_magi_eligibilities => [], :medicaid_non_magi_eligibilities => [], :aptc_eligibilities => [], :exchange_eligibilities => [], :csr_eligibilities => [], :chip_eligibilities => [], :temporarily_lives_outside_application_state_indicator => nil, :age_left_foster_care => nil, :foster_care_state => nil, :had_medicaid_during_foster_care_indicator => nil, :lives_with_minor_age_dependent_indicator => nil, :household_exception_indicator => nil, :referral_activity => nil, :foster_care_indicator => nil, :parent_average_hours_worked_per_week_values => nil } } }, "primary_applicant_identifier" => { :name => "primary_applicant_identifier", :item => "IDC1003158" }, "insurance_application.ssf_signer.ssf_attestation" => { :name => "insurance_application.ssf_signer.ssf_attestation", :item => { :collections_agreement_indicator => true, :medicaid_obligations_indicator => true, :non_perjury_indicator => true, :not_incarcerated_indicators => true, :privacy_agreement_indicator => true, :pending_charges_indicator => true, :information_changes_indicator => true, :application_terms_indicator => true } }, "tax_returns" => { :name => "tax_returns", :item => nil }, "record.people.IDC1003158" => { :name => "record.people.IDC1003158", :item => "IDC1003158" }, "person_name.first_name.IDC1003158" => { :name => "person_name.first_name.IDC1003158", :item => "Simple" }, "person_name.middle_name.IDC1003158" => { :name => "person_name.middle_name.IDC1003158", :item => "Transfer1" }, "person_name.last_name.IDC1003158" => { :name => "person_name.last_name.IDC1003158", :item => "L3" }, "person_name.full_name.IDC1003158" => { :name => "person_name.full_name.IDC1003158", :item => "Simple Transfer1 L3" }, "us_citizen_indicator.IDC1003158" => { :name => "us_citizen_indicator.IDC1003158", :item => true }, "person.person_demographics.gender.IDC1003158" => { :name => "person.person_demographics.gender.IDC1003158", :item => "male" }, "person.person_demographics.dob.IDC1003158" => { :name => "person.person_demographics.dob.IDC1003158", :item => "1941-01-01" }, "record.people.IDC1003158.tribal_augmentation" => { :name => "record.people.IDC1003158.tribal_augmentation", :item => { :recognized_tribe_indicator => nil, :american_indian_or_alaska_native_indicator => false, :person_tribe_name => nil, :location_state_us_postal_service_code => nil } }, "record.people.IDC1003158.augementation" => { :name => "record.people.IDC1003158.augementation", :item => { :us_naturalized_citizen_indicator => nil, :us_veteran_indicator => nil, :married_indicator => false, :pregnancy_status => { :status_indicator => false, :status_valid_date_range => nil, :expected_baby_quantity => nil }, :medicaid_id => nil, :chip_id => nil, :preferred_languages => [{ :speaks_language_indicator => nil, :writes_language_indicator => nil, :language_name => "english" }], :incomes => [{ :employment_source_text => nil, :amount => 78_100.0, :days_per_week => nil, :hours_per_pay_period => nil, :hours_per_week => nil, :category_code => "Wages", :description_text => nil, :subject_to_federal_restrictions_indicator => nil, :date => { :date => "2021-08-16", :date_time => "", :year => nil, :year_month => nil }, :earned_date_range => { :end_date => { :date => "2021-08-16", :date_time => "", :year => nil, :year_month => nil }, :start_date => { :date => "2021-08-16", :date_time => "", :year => nil, :year_month => nil } }, :frequency => { :frequency_code => "Annually" }, :payment_frequency => nil, :source_organization_reference => { :ref => "em2009481180751485382" } }], :expenses => [], :employments => [{ :begin_date => nil, :end_date => nil, :esi_augmentation => nil, :employer => { :id => "em2009481180751485382", :category_text => "City of Augusta Bank", :organization_primary_contact_information => { :email_id => nil, :mailing_address => { :address => nil }, :telephone_number => { :telephone => { :telephone_number_full_id => nil, :telephone_suffix_id => nil } } }, :organization_augmentation => nil } }], :contacts => [{ :begin_date => nil, :end_date => nil, :contact => { :email_id => nil, :mailing_address => { :address => { :location_street => { :street_full_text => "514 Test Street" }, :address_secondary_unit_text => "", :location_city_name => "Augusta", :location_county_name => "KENNEBEC", :location_county_code => nil, :location_state_us_postal_service_code => "ME", :location_postal_code => "04330" } }, :telephone_number => { :telephone => { :telephone_number_full_id => nil, :telephone_suffix_id => nil } } }, :category_code => "Home", :is_primary_indicator => false }, { :begin_date => nil, :end_date => nil, :contact => { :email_id => nil, :mailing_address => { :address => { :location_street => { :street_full_text => "37 ML" }, :address_secondary_unit_text => "", :location_city_name => "Augusta", :location_county_name => "KENNEBEC", :location_county_code => nil, :location_state_us_postal_service_code => "ME", :location_postal_code => "04330" } }, :telephone_number => { :telephone => { :telephone_number_full_id => nil, :telephone_suffix_id => nil } } }, :category_code => "Mailing", :is_primary_indicator => false }, { :begin_date => nil, :end_date => nil, :contact => { :email_id => nil, :mailing_address => { :address => nil }, :telephone_number => { :telephone => { :telephone_number_full_id => "3011510342", :telephone_suffix_id => nil } } }, :category_code => "Mobile", :is_primary_indicator => false }, { :begin_date => nil, :end_date => nil, :contact => { :email_id => "M80@gmail.com", :mailing_address => { :address => nil }, :telephone_number => { :telephone => { :telephone_number_full_id => nil, :telephone_suffix_id => nil } } }, :category_code => "Home", :is_primary_indicator => false }], :family_relationships => [], :person_identification => nil } }, "record.people.IDC1002699" => { :name => "record.people.IDC1002699", :item => "IDC1002699" }, "person_name.first_name.IDC1002699" => { :name => "person_name.first_name.IDC1002699", :item => "Helen" }, "person_name.middle_name.IDC1002699" => { :name => "person_name.middle_name.IDC1002699", :item => nil }, "person_name.last_name.IDC1002699" => { :name => "person_name.last_name.IDC1002699", :item => "test" }, "person_name.full_name.IDC1002699" => { :name => "person_name.full_name.IDC1002699", :item => "Helen test" }, "us_citizen_indicator.IDC1002699" => { :name => "us_citizen_indicator.IDC1002699", :item => true }, "person.person_demographics.gender.IDC1002699" => { :name => "person.person_demographics.gender.IDC1002699", :item => "female" }, "person.person_demographics.dob.IDC1002699" => { :name => "person.person_demographics.dob.IDC1002699", :item => "1997-01-01" }, "record.people.IDC1002699.tribal_augmentation" => { :name => "record.people.IDC1002699.tribal_augmentation", :item => { :recognized_tribe_indicator => nil, :american_indian_or_alaska_native_indicator => false, :person_tribe_name => nil, :location_state_us_postal_service_code => nil } }, "record.people.IDC1002699.augementation" => { :name => "record.people.IDC1002699.augementation", :item => { :us_naturalized_citizen_indicator => nil, :us_veteran_indicator => nil, :married_indicator => false, :pregnancy_status => { :status_indicator => false, :status_valid_date_range => nil, :expected_baby_quantity => nil }, :medicaid_id => nil, :chip_id => nil, :preferred_languages => [{ :speaks_language_indicator => nil, :writes_language_indicator => nil, :language_name => "english" }], :incomes => [], :expenses => [], :employments => [], :contacts => [{ :begin_date => nil, :end_date => nil, :contact => { :email_id => nil, :mailing_address => { :address => { :location_street => { :street_full_text => "514 Test Street" }, :address_secondary_unit_text => "", :location_city_name => "Augusta", :location_county_name => "KENNEBEC", :location_county_code => nil, :location_state_us_postal_service_code => "ME", :location_postal_code => "04330" } }, :telephone_number => { :telephone => { :telephone_number_full_id => nil, :telephone_suffix_id => nil } } }, :category_code => "Home", :is_primary_indicator => false }, { :begin_date => nil, :end_date => nil, :contact => { :email_id => nil, :mailing_address => { :address => { :location_street => { :street_full_text => "37 ML" }, :address_secondary_unit_text => "", :location_city_name => "Augusta", :location_county_name => "KENNEBEC", :location_county_code => nil, :location_state_us_postal_service_code => "ME", :location_postal_code => "04330" } }, :telephone_number => { :telephone => { :telephone_number_full_id => nil, :telephone_suffix_id => nil } } }, :category_code => "Mailing", :is_primary_indicator => false }, { :begin_date => nil, :end_date => nil, :contact => { :email_id => nil, :mailing_address => { :address => nil }, :telephone_number => { :telephone => { :telephone_number_full_id => "3012228342", :telephone_suffix_id => nil } } }, :category_code => "Mobile", :is_primary_indicator => false }, { :begin_date => nil, :end_date => nil, :contact => { :email_id => "H24@gmail.com", :mailing_address => { :address => nil }, :telephone_number => { :telephone => { :telephone_number_full_id => nil, :telephone_suffix_id => nil } } }, :category_code => "Home", :is_primary_indicator => false }], :family_relationships => [], :person_identification => nil } }, "record.people.IDC1003159" => { :name => "record.people.IDC1003159", :item => "IDC1003159" }, "person_name.first_name.IDC1003159" => { :name => "person_name.first_name.IDC1003159", :item => "Robert" }, "person_name.middle_name.IDC1003159" => { :name => "person_name.middle_name.IDC1003159", :item => nil }, "person_name.last_name.IDC1003159" => { :name => "person_name.last_name.IDC1003159", :item => "test2" }, "person_name.full_name.IDC1003159" => { :name => "person_name.full_name.IDC1003159", :item => "Robert test2" }, "us_citizen_indicator.IDC1003159" => { :name => "us_citizen_indicator.IDC1003159", :item => true }, "person.person_demographics.ssn.IDC1003159" => { :name => "person.person_demographics.ssn.IDC1003159", :item => "213828500" }, "person.person_demographics.gender.IDC1003159" => { :name => "person.person_demographics.gender.IDC1003159", :item => "male" }, "person.person_demographics.dob.IDC1003159" => { :name => "person.person_demographics.dob.IDC1003159", :item => "2010-01-01" }, "record.people.IDC1003159.tribal_augmentation" => { :name => "record.people.IDC1003159.tribal_augmentation", :item => { :recognized_tribe_indicator => nil, :american_indian_or_alaska_native_indicator => false, :person_tribe_name => nil, :location_state_us_postal_service_code => nil } }, "record.people.IDC1003159.augementation" => { :name => "record.people.IDC1003159.augementation", :item => { :us_naturalized_citizen_indicator => nil, :us_veteran_indicator => nil, :married_indicator => false, :pregnancy_status => { :status_indicator => false, :status_valid_date_range => nil, :expected_baby_quantity => nil }, :medicaid_id => nil, :chip_id => nil, :preferred_languages => [{ :speaks_language_indicator => nil, :writes_language_indicator => nil, :language_name => "english" }], :incomes => [], :expenses => [], :employments => [], :contacts => [{ :begin_date => nil, :end_date => nil, :contact => { :email_id => nil, :mailing_address => { :address => { :location_street => { :street_full_text => "510 Test Street" }, :address_secondary_unit_text => "", :location_city_name => "Augusta", :location_county_name => "KENNEBEC", :location_county_code => nil, :location_state_us_postal_service_code => "ME", :location_postal_code => "04330" } }, :telephone_number => { :telephone => { :telephone_number_full_id => nil, :telephone_suffix_id => nil } } }, :category_code => "Home", :is_primary_indicator => false }, { :begin_date => nil, :end_date => nil, :contact => { :email_id => nil, :mailing_address => { :address => { :location_street => { :street_full_text => "37 ML" }, :address_secondary_unit_text => "", :location_city_name => "Augusta", :location_county_name => "KENNEBEC", :location_county_code => nil, :location_state_us_postal_service_code => "ME", :location_postal_code => "04330" } }, :telephone_number => { :telephone => { :telephone_number_full_id => nil, :telephone_suffix_id => nil } } }, :category_code => "Mailing", :is_primary_indicator => false }, { :begin_date => nil, :end_date => nil, :contact => { :email_id => nil, :mailing_address => { :address => nil }, :telephone_number => { :telephone => { :telephone_number_full_id => "2021768341", :telephone_suffix_id => nil } } }, :category_code => "Mobile", :is_primary_indicator => false }, { :begin_date => nil, :end_date => nil, :contact => { :email_id => "RH10@gmail.com", :mailing_address => { :address => nil }, :telephone_number => { :telephone => { :telephone_number_full_id => nil, :telephone_suffix_id => nil } } }, :category_code => "Home", :is_primary_indicator => false }], :family_relationships => [], :person_identification => nil } } }
    # rubocop:enable Layout/LineLength
    AcaEntities::Operations::Transforms::Context.new(context_hash)
  end
end
