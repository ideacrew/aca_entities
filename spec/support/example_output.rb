# functions:
#   generate hbx ID for family, family member, person
#   match primary family member with members instance
#   tranform relationship mapping
#   dynamically construct output namespace
#
# triggers:
#   record delimeter
#   family: attestations.application
#   person: attestations.application.household.familyRelationships

'families.family' => {
  hbx_id:,
  renewal_consent_through_year:
  vlp_documents_status:
  min_verifications_due_date:
  special_enrollment_periods: [{}],
  irs_groups: [{}],
  broker_agency_accounts: [{}],
  general_agency_accounts: [{}],
  documents: [{}],
  payment_transactions: [{}],
  financial_assistance_applications: [{
  }],
  family_members: [
    {
      is_primary_applicant: true,
      is_coverage_applicant: true,
      is_consent_applicant: true,
      person: {
        identifiers: [{
                        source_system_key: 'ffm',
                        ids: [{
                                key: 'members',
                                item: '1435239665677772593'
                        }]
        }],
        names: [{
                  first_name: 'Roslyn',
                  last_name: 'dshab'
        }],
        hbx_id:,
        is_disabled: false, # SHOP?, IVL:nonMagi:blindOrDisabledIndicator
        ethnicity:,
        race:,
        tribal_id: nil, # americanIndianAlaskanNativeIndicator
        language_code: "en",
        is_homeless: false,
        is_temporarily_out_of_state: false,
        encrypted_ssn: nil,
        dob: "1969-03-01",
        gender: "FEMALE", # transform value to our gender type
        no_ssn: true,
        emails: [{
                   kind: 'unknown',
                   address: 'assewappemu-8843@yopmail.com'
        }],
        phones: [{
                   kind: 'home',
                   country_code:,
                   area_code:,
                   number: '2025547416',
                   extension: '1',
                   primary: true
        }],
        addresses: [{
                      has_fixed_address:,
                      kind: 'home',
                      address_1: '2 commerce street',
                      address_2: ,
                      city: "Harrington",
                      county: "Lander",
                      county_code: "32015",
                      state: "NV",
                      zip: "89310",
                      country_name: "USA",
                      validation_status:,
                      start_on:, # imported date
                      end_on:,
                      lives_outside_state_temporarily: false
        }],
        person_relationships:[{
                                relative_hbx_id: ,
                                kind: 'self'
        }]
      },
      hbx_id:
    }
  ],
  households: {
    coverage_households:[{}],
    tax_households: [{}],
    hbx_enrollments: [{}]
  }
}
