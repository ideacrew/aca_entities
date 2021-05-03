# frozen_string_literal: true

# This file defines the maps
module AcaEntities
  module Operations
    module TransformExamples
      module McrTo
        # Transform Keys and Values
        class CvInput < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          record_delimiter 'applications.identifier.result'
          # source_vocabulary :mcr

          AgeOn = AcaEntities::Functions::AgeOn.new(on_date: '2020-1-1')

        
          map 'coverageYear', 'family.magi_medicaid_applications.assistance_year'
          map 'insuranceApplicationIdentifier', 'family.hbx_id'
          map 'lastUpdateMetadata', 'lastUpdateMetadata', memoize_record: true

          namespace 'attestations' do
          
            rewrap 'family', type: :hash do
              map 'insuranceApplicationIdentifier', 'hbx_id'
              add_key 'foreign_keys'
              namespace 'application' do
                map 'spokenLanguageType', 'family_members.person.consumer_role.language_preference', memoize: true, visible: false

                namespace 'legalAttestations' do
                  map 'renewEligibilityYearQuantity', 'renewal_consent_through_year'
                  map 'absentParentAgreementIndicator', 'magi_medicaid_applications.parent_living_out_of_home_terms'
                  map 'changeInformationAgreementIndicator', 'magi_medicaid_applications.report_change_terms'
                  map 'medicaidRequirementAgreementIndicator', 'magi_medicaid_applications.medicaid_terms'
                  map 'renewalAgreementIndicator', 'magi_medicaid_applications.is_renewal_authorized'
                end
              end

              add_key 'general_agency_accounts', value: ->(_v) {[]}
              add_key 'special_enrollment_periods', value: ->(_v) {[]}
              add_key 'irs_groups', value: ->(_v) {[]}
              add_key 'broker_accounts', value: ->(_v) {[]}
              add_key 'documents', value: ->(_v) {[]}
              add_key 'payment_transactions', value: ->(_v) {[]}
              map 'application.contactMemberIdentifier', 'family.family_members.is_primary_applicant', memoize: true, visible: false
              map 'application.contactInformation.email', 'family.family_members.person.email.address', memoize: true, visible: false
              map 'application.contactInformation.primaryPhoneNumber.number', 'family.family_members.person.phone.number', memoize: true, visible: false
              map 'application.contactInformation.primaryPhoneNumber.ext', 'family.family_members.person.phone.ext', memoize: true, visible: false
              map 'application.contactInformation.primaryPhoneNumber.type', 'family.family_members.person.phone.type', memoize: true, visible: false
              # map 'application.contactMethod', 'family.family_members.person.consumer_role.contact_method', memoize_record: true, visible: false

              # transform not working
              # revist the code for values as array
              # map 'household.familyRelationships', 'family_members.person.family_Relationships',
              # memoize: true

              # namespace 'household' do
              #   namespace 'familyRelationships' do
              #     rewrap 'familyRelationships', type: :array do
              #       map
              #     end
              #   end

              #   map 'household.familyRelationships', 'family.family_members.person.family_Relationships', memoize: true
              # end

              namespace 'members.*', nil, context: {name: 'members'} do
                rewrap 'family.family_members', type: :array do
                  # rubocop:disable Style/Lambda
                  add_key 'is_primary_applicant', function: ->(v) {
                    v.resolve('family.family_members.is_primary_applicant').item == v.resolve(:members).item
                  }
                  # rubocop:enable Style/Lambda
                  map 'requestingCoverageIndicator', 'is_coverage_applicant'
                  add_key 'is_active'
                  add_key 'is_consent_applicant'
                  add_key 'foreign_keys'

                  namespace 'demographic' do
                    rewrap 'family.family_members.person', type: :hash do
                      # add_key 'family_Relationships', function: AcaEntities::Functions::BuildRelationships.new
                      add_key 'hbx_id', value: ''

                      add_namespace 'identifiers', type: :array do
                        add_key 'source_system_key', value: 'ccr' # source_vocabulary

                        add_namespace 'ids', type: :array do
                          add_key 'key', function: ->(v) {v.resolve(:members).name} # should be derived based on context
                          add_key 'item', function: ->(v) {v.resolve(:members).item} # should pick id from the source payload
                        end
                      end

                      # namespace 'name' do
                      #   rewrap 'family.family_members.person.person_name', type: :hash do
                      #     map 'firstName', 'first_name', context: {name: 'first_name'}
                      #     map 'lastName', 'last_name', context: {name: 'last_name'}
                      #     add_key 'full_name', function: ->(v) {[v.resolve(:first_name).item, v.resolve(:last_name).item].join(' ')}
                      #   end
                      # end
                      map 'noHomeAddressIndicator', 'is_homeless'
                      map 'liveOutsideStateTemporarilyIndicator', 'is_temporarily_out_of_state'
                      map 'requestingFinancialAssistanceIndicator', 'is_applying_for_assistance'
                      add_key 'is_active'
                      add_key 'is_disabled'
                      add_key 'person_relationships', value: ->(_v) {[]}
                      add_key 'consumer_role', value: ->(_v) {{}}
                      add_key 'consumer_role.requested_coverage_start_date'
                      add_key 'consumer_role.aasm_state'
                      add_key 'consumer_role.is_applicant'
                      add_key 'consumer_role.birth_location'
                      map 'maritalStatus', 'consumer_role.marital_status'
                      add_key 'consumer_role.is_active'
                      add_key 'consumer_role.is_applying_coverage'
                      add_key 'consumer_role.bookmark_url'
                      add_key 'consumer_role.admin_bookmark_url'
                      # transform not working
                      # revist the code for values as array
                      # add_key 'consumer_role.contact_method', function: ->(v) {  v.resolve("family.family_members.person.consumer_role.contact_method").item}
                      add_key 'consumer_role.language_preference', function: ->(v) {v.resolve('family_members.person.consumer_role.language_preference').item}
                      add_key 'consumer_role.is_state_resident'
                      add_key 'consumer_role.identity_validation'
                      add_key 'consumer_role.identity_update_reason'
                      add_key 'consumer_role.application_validation'
                      add_key 'consumer_role.application_update_reason'
                      add_key 'consumer_role.identity_rejected'
                      add_key 'consumer_role.application_rejected'
                      add_key 'consumer_role.documents', value: ->(_v) {[]}
                      add_key 'consumer_role.vlp_documents', value: ->(_v) {[]}
                      add_key 'consumer_role.ridp_documents', value: ->(_v) {[]}
                      add_key 'consumer_role.verification_type_history_elements', value: ->(_v) {[]}

                      add_key 'consumer_role.local_residency_responses', value: ->(_v) {[]}
                      add_key 'consumer_role.local_residency_requests', value: ->(_v) {[]}

                      add_key 'resident_role'
                      add_key 'individual_market_transitions', value: ->(_v) {[]}
                      add_key 'verification_types', value: ->(_v) {[]}
                      add_key 'broker_role'
                      # , function : ->(v) {
                      #   v.resolve('family.family_members.is_primary_applicant').item == v.resolve(:members).item
                      # }
                      add_key 'emails', function: ->(v) {
                        if v.resolve('family.family_members.is_primary_applicant').item == v.resolve(:members).item
                          [{address: v.resolve('family.family_members.person.email.address').item, kind: 'home'}]
                        end
                      }
                      add_key 'phones', function: lambda {|v|
                        if v.resolve('family.family_members.is_primary_applicant').item == v.resolve(:members).item
                          [{extension: v.resolve('family.family_members.person.phone.ext').item,
                            kind: v.resolve('family.family_members.person.phone.type').item,
                            area_code: v.resolve('family.family_members.person.phone.number').item[0..2],
                            number: v.resolve('family.family_members.person.phone.number').item[3..9],
                            primary: nil,
                            full_phone_number: [v.resolve('family.family_members.person.phone.ext').item, v.resolve('family.family_members.person.phone.number').item].join(''),
                            start_on: nil,
                            end_on: nil}]
                        end
                      }
                      add_key 'documents', value: ->(_v) {[]}
                      add_key 'age_off_excluded'
                      map 'sex', 'person_demographics.sex', action: :nest, function: ->(value) {value.to_s.downcase}
                      map 'birthDate', 'person_demographics.birthDate', action: :nest, function: AgeOn
                      # transform not working
                      # revist the code for values as array
                      # map 'ethnicity', 'person_demographics.ethnicity'
                      # map 'race', 'person_demographics.race'
                      add_key 'person_demographics.tribal_id'
                      add_key 'person_demographics.no_ssn'
                      add_key 'person_demographics.language_code'
                      add_key 'person_demographics.date_of_death'
                      add_key 'person_demographics.dob_check'

                      map 'noHomeAddressIndicator', 'is_homeless'
                      map 'liveOutsideStateTemporarilyIndicator', 'is_temporarily_out_of_state'


                      add_namespace 'tax_household_members', type: :array do
                        rewrap 'family.household.tax_households.tax_household_members', type: :array do
                          add_key 'kind', value: 'home'
                        
                        end
                      end

                      namespace 'mailingAddress' do
                        rewrap 'family.family_members.person.addresses', type: :array do
                          add_key 'kind', value: 'mailing'
                          map 'streetName1', 'address_1'
                          add_key 'address_2'
                          add_key 'address_3'
                          map 'cityName', 'city'
                          map 'countyName', 'county'
                          map 'countyFipsCode', 'county_code'
                          map 'stateCode', 'state'
                          map 'zipCode', 'zip'
                          map 'countryCode', 'country_name'
                        end
                      end

                      namespace 'homeAddress' do
                        rewrap 'family.family_members.person.addresses', type: :array do
                          add_key 'kind', value: 'home'
                          map 'streetName1', 'address_1'
                          add_key 'address_2'
                          add_key 'address_3'
                          map 'cityName', 'city'
                          map 'countyName', 'county'
                          map 'countyFipsCode', 'county_code'
                          map 'stateCode', 'state'
                          map 'zipCode', 'zip'
                          map 'countryCode', 'country_name'
                        end
                      end
                    end
                  end

                  transform not working
                  revist the code for values as array
                  map 'income', 'income' , memoize_record: true
                  # [1,2,3,4,5].each do |i|
                  #   map "income.currentIncome.currentIncome#{i}","family.magi_medicaid_applications.'->(v){v.resolve(:members).item}'.income.currentIncome.currentIncome#{i}" , memoize_record: true, visible: false
                  # end

                  map 'lawfulPresence.noAlienNumberIndicator', 'noAlienNumberIndicator', memoize: true, visible: false
                  map 'lawfulPresence.citizenshipIndicator', 'citizenshipIndicator', memoize: true, visible: false
                  map 'lawfulPresence.naturalizedCitizenIndicator', 'naturalizedCitizenIndicator', memoize: true, visible: false

                  add_key 'person.consumer_role.lawful_presence_determination.citizen_status', function: AcaEntities::Functions::BuildLawfulPresenceDetermination.new

                  add_key 'person_health.is_tobacco_user'
                  map 'nonMagi.blindOrDisabledIndicator', 'person_health.is_physically_disabled'
                  map 'other.americanIndianAlaskanNative.personRecognizedTribeIndicator',
                      'person.person_demographics.personRecognizedTribeIndicator'
                  map 'other.incarcerationType', 'person.person_demographics.is_incarcerated', function: ->(value) {AcaEntities::Types::McrToCvIncarcerationKind[value]}
                end
              end

              add_key 'household.start_date'
              add_key 'household.end_date'
              add_key 'household.is_active'
              add_key 'household.irs_group'
              add_key 'household.tax_households', value: ->(_v) {[]}
              # add_key 'household.tax_households.tax_household_members' {}
              # add_key 'household.tax_households.eligibility_determinations', value: ->(_v) {Array.new}
              add_key 'household.coverage_households', value: ->(_v) {[]}
              add_key 'household.hbx_enrollments', value: ->(_v) {[]}

              # transform not working to build array (type: array for add namespace)
              # revist the code
              # namespace "computed" do
              #   namespace 'taxHouseholds.*', nil, context: {name: 'taxHouseholdsmembers'} do
              #     map 'maxAPTC', "maxAPTC.'->(v){v.resolve(:taxHouseholdsmembers).item}'", memoize: true, visible: false
              #     map 'taxHouseHoldComposition', "taxHouseHoldComposition.'->(v){v.resolve(:taxHouseholdsmembers).item}'", memoize: true, visible: false

              #     # add_key 'person.consumer_role.lawful_presence_determination.citizen_status', function: AcaEntities::Functions::BuildLawfulPresenceDetermination.new

              #   end
              #   # namespace "members.*", nil, context: {name: 'members'} do
              #   # end
              # end
              # add_namespace 'household', type: :hash do
              #   add_namespace 'tax_households', type: :array do
              #     add_key 'hbx_id'
              #     add_key 'allocated_aptc'
              #     add_key 'is_eligibility_determined'
              #     add_key 'start_date'
              #     add_key 'end_date'
              #     add_namespace 'tax_household_members', type: :array do
              #       add_namespace 'family_member_reference', type: :hash do
              #         add_key 'family_member_hbx_id'
              #         add_key 'first_name', function: ->(v) { v.resolve(:first_name).item }
              #         add_key 'last_name', function: ->(v) { v.resolve(:last_name).item }
              #         add_key 'person_hbx_id'
              #         add_key 'is_primary_family_member', function: ->(v) {v.resolve('family.family_members.is_primary_applicant').item == v.resolve(:members).item}
              #       end
              #       add_namespace 'product_eligibility_determination', type: :hash do
              #         add_key 'is_ia_eligible'
              #         add_key 'is_medicaid_chip_eligible'
              #         add_key 'is_non_magi_medicaid_eligible'
              #         add_key 'is_totally_ineligible'
              #         add_key 'is_without_assistance'
              #         add_key 'is_magi_medicaid'
              #         add_key 'magi_medicaid_monthly_household_income'
              #         add_key 'medicaid_household_size'
              #         add_key 'magi_medicaid_monthly_income_limit'
              #         add_key 'magi_as_percentage_of_fpl'
              #         add_key 'magi_medicaid_category'
              #       end
              #       add_key 'is_subscriber', function: ->(v) {v.resolve('family.family_members.is_primary_applicant').item == v.resolve(:members).item}
              #       add_key 'reason'
              #     end
              #   end
              # end


              # namespace 'application' do
              #   namespace 'legalAttestations' do
              #     rewrap 'magi_medicaid_applications', type: :hash do
              #       map "absentParentAgreementIndicator", "parent_living_out_of_home_terms"
              #       map "changeInformationAgreementIndicator", "report_change_terms"
              #       map "medicaidRequirementAgreementIndicator", "medicaid_terms"
              #       map "renewalAgreementIndicator", "is_renewal_authorized"
              #     end
              #   end
              # end

           
              # add_namespace 'applicants', 'magi_medicaid_applications.applicants', type: :array do
              #   add_key 'name'
              #   add_key 'identifying_information'
              #   add_key 'demographic'
              #   add_key 'attestation'
              #   add_key 'is_primary_applicant'
              #   add_key 'native_american_information'
              #   add_key 'citizenship_immigration_status_information'

              #   add_key 'is_consumer_role'
              #   add_key 'is_resident_role'
              #   add_key 'is_applying_coverage'
              #   add_key 'is_consent_applicant'
              #   add_key 'vlp_document'
              #   add_key 'family_member_reference'

              #   add_key 'person_hbx_id'

              #   add_key 'is_required_to_file_taxes'
              #   add_key 'tax_filer_kind'
              #   add_key 'is_joint_tax_filing'
              #   add_key 'is_claimed_as_tax_dependent'
              #   add_key 'claimed_as_tax_dependent_by'

              #   add_key 'student'
              #   add_key 'is_refugee'
              #   add_key 'is_trafficking_victim'
              #   add_key 'foster_care'
              #   add_key 'pregnancy_information'

              #   # TODO: do we want to move these anywhere?
              #   add_key 'is_subject_to_five_year_bar'
              #   add_key 'is_five_year_bar_met'
              #   add_key 'is_forty_quarters'
              #   add_key 'is_ssn_applied'
              #   add_key 'non_ssn_apply_reason'
              #   # 5 Yr. Bar QNs.
              #   add_key 'moved_on_or_after_welfare_reformed_law'
              #   add_key 'is_currently_enrolled_in_health_plan'

              #   # Other QNs.
              #   add_key 'has_daily_living_help'
              #   add_key 'need_help_paying_bills'

              #   # Driver QNs.
              #   add_key 'has_job_income'
              #   add_key 'has_self_employment_income'
              #   add_key 'has_unemployment_income'
              #   add_key 'has_other_income'
              #   add_key 'has_deductions'
              #   add_key 'has_enrolled_health_coverage'
              #   add_key 'has_eligible_health_coverage'

              #   add_namespace 'incomes', 'magi_medicaid_applications.applicants.incomes', type: :array do
              #     add_key 'title'
              #     add_key 'kind'
              #     add_key 'wage_type'
              #     add_key 'hours_per_week'
              #     # transform not working for array values
              #     # revist the code
              #     # add_key 'amount', function: ->(v) { v.resolve("family.magi_medicaid_applications.'->(v){v.resolve(:members).item}'.income.currentIncome.currentIncome#{i}").item }
              #     add_key 'amount_tax_exempt'
              #     add_key 'frequency_kind'
              #     add_key 'start_on'
              #     add_key 'end_on'
              #     add_key 'is_projected'
              #     add_key 'employer'
              #     add_key 'has_property_usage_rights'
              #     add_key 'submitted_at'
              #   end

              #   add_namespace 'benefits', 'magi_medicaid_applications.applicants.benefits', type: :array do
              #     add_key 'name'
              #     # insurance_kind
              #     add_key 'kind'
              #     # kind
              #     add_key 'status'
              #     add_key 'is_employer_sponsored'
              #     add_key 'employer'
              #     add_key 'esi_covered'
              #     add_key 'is_esi_waiting_period'
              #     add_key 'is_esi_mec_met'
              #     # Money
              #     add_key 'employee_cost'
              #     add_key 'employee_cost_frequency'
              #     add_key 'start_on'
              #     add_key 'end_on'
              #     add_key 'submitted_at'
              #   end

              #   add_namespace 'deductions', 'magi_medicaid_applications.applicants.deductions', type: :array do
              #     add_key 'name'
              #     add_key 'kind'
              #     add_key 'amount'
              #     add_key 'start_on'
              #     add_key 'end_on'
              #     add_key 'frequency_kind'
              #     add_key 'submitted_at'
              #   end
              # end
            end
          end
          # namespace 'computed' do 
          #   namespace 'members' do
          #   map "*" , "member" , memoize_record: true
          #   end
          # end
          # add_key 'family.magi_medicaid_applications.applicants', function:  AcaEntities::Functions::BuildApplicants.new
         


          # namespace "computed" do
          #   rewrap 'family', type: :hash do
          #     namespace 'taxHouseholds.*', nil, context: {name: 'taxHouseholdsmembers'} do
          #       rewrap 'household.tax_households' , type: :array do
          #         map 'maxAPTC', "maxAPTC.'->(v){v.resolve(:taxHouseholdsmembers).item}'", memoize: true, visible: false
          #         map 'taxHouseHoldComposition', "taxHouseHoldComposition.'->(v){v.resolve(:taxHouseholdsmembers).item}'", memoize: true, visible: false
          #       end
          #       # add_key 'person.consumer_role.lawful_presence_determination.citizen_status', function: AcaEntities::Functions::BuildLawfulPresenceDetermination.new

          #     end
          #   end
          #   # namespace "members.*", nil, context: {name: 'members'} do
          #   # end
          # end

          # transform not working to build array and for wildcard matching person
          # revist the code
          # map 'computed.members.*.fiveYearBarStatus', 'family.family_members.person.consumer_role.five_year_bar'
        end
      end
    end
  end
end
