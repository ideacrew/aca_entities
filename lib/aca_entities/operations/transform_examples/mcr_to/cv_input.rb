# frozen_string_literal: true

require 'aca_entities/functions/relationship_builder'
require 'aca_entities/functions/age_on'
require 'aca_entities/functions/primary_applicant_builder'
require 'aca_entities/functions/build_lawful_presence_determination'
require 'aca_entities/functions/build_application'
require 'aca_entities/functions/build_household'

# rubocop:disable Metrics/ClassLength
# This file defines the maps
module AcaEntities
  module Operations
    module TransformExamples
      module McrTo
        # Transform Keys and Values
        class CvInput < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          # start transform from this record_delimiter key in the given JSON record
          record_delimiter 'applications.identifier.result'

          # map 'source key from hash', 'namespaced output key/rename key',
          ### memoize: (to store this particular key in memory for later use),
          ### visible: (to display in output hash)
          map 'coverageYear', 'assistance_year', memoize: true, visible: false

          ### function: (for value transform)
          map 'insuranceApplicationIdentifier', 'family.hbx_id', function: ->(value) { value.to_s }, memoize: true

          ### memoize_record: (to store entire hash under this particular key in memory for later use)
          map 'lastUpdateMetadata', 'lastUpdateMetadata', memoize_record: true

          # namespace 'source key from hash' and block
          namespace 'attestations' do
            # rewrap elements under attestations to family
            ### type: (build family as :hash or :array)
            rewrap 'family', type: :hash do
              # Only elements mentioned in rewrap is assigned to family

              # add_key 'new key/ namespaced key'
              ### value: ->(_v) {}
              ### function:  as a proc or a custom build function
              add_key 'foreign_keys', value: ->(_v) { [] }
              namespace 'application' do
                map 'spokenLanguageType', 'family_members.person.consumer_role.language_preference', memoize: true, visible: false

                namespace 'legalAttestations' do
                  map 'renewEligibilityYearQuantity', 'renewal_consent_through_year', function: ->(_value) { Date.parse("2021-05-07").year }
                  map 'absentParentAgreementIndicator', 'parent_living_out_of_home_terms', memoize: true, visible: false
                  map 'changeInformationAgreementIndicator', 'report_change_terms', memoize: true, visible: false
                  map 'medicaidRequirementAgreementIndicator', 'medicaid_terms', memoize: true, visible: false
                  map 'renewalAgreementIndicator', 'is_renewal_authorized', memoize: true, visible: false
                end
              end

              add_key 'general_agency_accounts', value: ->(_v) { [] }
              add_key 'special_enrollment_periods', value: ->(_v) { [] }
              add_key 'irs_groups', value: ->(_v) { [] }
              add_key 'broker_accounts', value: ->(_v) { [] }
              add_key 'documents', value: ->(_v) { [] }
              add_key 'payment_transactions', value: ->(_v) { [] }
              map 'application.contactMemberIdentifier', 'family.family_members.is_primary_applicant', memoize: true, visible: false
              map 'application.contactInformation.email', 'family.family_members.person.email.address', memoize: true, visible: false
              map 'application.contactInformation.primaryPhoneNumber.number', 'family.family_members.person.phone.number', memoize: true,
                                                                                                                            visible: false
              map 'application.contactInformation.primaryPhoneNumber.ext', 'family.family_members.person.phone.ext', memoize: true, visible: false
              map 'application.contactInformation.primaryPhoneNumber.type', 'family.family_members.person.phone.type', memoize: true, visible: false

              # original key is also passed to the output hash, revist code for this scenario
              map 'application.contactMethod', 'family.family_members.person.consumer_role.contact_method', memoize: true, visible: false

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
              # map 'household.familyRelationships', 'household.familyRelationships'

              map 'household', 'family.family_members.person.family_Relationships', memoize_record: true, visible: false
              # namespace 'household.familyRelationships' do
              #   rewrap  'family.family_members.person.family_Relationships', type: :array do
              #     rewrap '', type: :array do
              #     end
              #   end
              # end
              # end

              #  namespace 'household' do
              #   namespace 'familyRelationships' do
              #     rewrap 'familyR', type: :array do
              #       rewrap '', type: :array do
              #         rewrap '', type: :hash do
              #           map 'resideTogetherIndicator', 'resideTogetherIndicator'
              #           map 'caretakerRelativeIndicator', 'caretakerRelativeIndicator'
              #         end
              #       end

              #     end
              #   end
              # end

              ### context: (to store this particular wild card key in memory for later use),
              namespace 'members.*', nil, context: { name: 'members' } do
                rewrap 'family.family_members', type: :array do
                  add_key 'is_primary_applicant', function: lambda { |v|
                    v.resolve('family.family_members.is_primary_applicant').item == v.find(/attestations.members.(\w+)$/).map(&:item).last
                  }
                  map 'requestingCoverageIndicator', 'is_coverage_applicant'
                  add_key 'is_active'
                  add_key 'is_consent_applicant'
                  add_key 'foreign_keys', value: ->(_v) { [] }
                  add_key 'hbx_id', value: '1234'

                  namespace 'demographic' do
                    rewrap 'family.family_members.person', type: :hash do
                      # add_key 'family_Relationships', function: AcaEntities::Functions::BuildRelationships.new
                      add_key 'hbx_id', value: '1234' # default value

                      # add_namespace 'new namespace key', 'namespace path for new namespace key', type: :hash
                      # add new namespace of type hash as provided in output namespaced key
                      add_namespace 'identifiers', 'family.family_members.person.identifiers', type: :hash do
                        add_key 'source_system_key', value: 'ccr' # source_vocabulary

                        add_namespace 'ids', 'family.family_members.person.identifiers.ids', type: :hash do
                          add_key 'key', function: lambda {|v|
                            v.resolve('attestations.members', identifier: true).name
                          }
                          #->(v) {v.find(Regexp.new("attestations.members")).map(&:name).last} # should be derived based on context
                          add_key 'item', function: lambda {|v|
                            v.resolve('attestations.members', identifier: true).item
                          }
                          # should pick id from the source payload
                        end
                      end

                      namespace 'name' do
                        rewrap 'family.family_members.person.person_name', type: :hash do
                          map 'firstName', 'first_name', memoize: true, append_identifier: true
                          map 'lastName', 'last_name', memoize: true, append_identifier: true
                          add_key 'full_name',
                                  function: lambda {|v|
                                    [v.resolve(:first_name, identifier: true).item, v.resolve(:last_name, identifier: true).item].join(' ')
                                  }
                        end
                      end

                      map 'noHomeAddressIndicator', 'is_homeless'
                      map 'liveOutsideStateTemporarilyIndicator', 'is_temporarily_out_of_state'
                      map 'requestingFinancialAssistanceIndicator', 'is_applying_for_assistance'
                      add_key 'is_active', value: true # default value
                      add_key 'person_relationships', function: AcaEntities::Functions::RelationshipBuilder.new
                      map 'maritalStatus', 'consumer_role.marital_status'
                      add_namespace 'consumer_role', 'family.family_members.person.consumer_role', type: :hash do
                        add_key 'five_year_bar'
                        add_key 'requested_coverage_start_date', value: ->(_v) {Date.parse("2021-05-07")} # default value
                        add_key 'aasm_state'
                        add_key 'is_applicant', function: lambda {|v|
                          v.resolve('family.family_members.is_primary_applicant').item == v.find(/attestations.members.(\w+)$/).map(&:item).last
                        }
                        add_key 'birth_location'
                        add_key 'is_active'
                        add_key 'is_applying_coverage', value: true # default value
                        add_key 'bookmark_url'
                        add_key 'admin_bookmark_url'
                        add_key 'contact_method',
                                function: ->(v) {v.resolve('family.family_members.person.consumer_role.contact_method').item&.first}
                        add_key 'language_preference',
                                function: ->(v) {v.resolve('family_members.person.consumer_role.language_preference').item}
                        add_key 'is_state_resident'
                        add_key 'identity_validation'
                        add_key 'identity_update_reason'
                        add_key 'application_validation'
                        add_key 'application_update_reason'
                        add_key 'identity_rejected'
                        add_key 'application_rejected'
                        add_key 'documents', value: ->(_v) {[]}
                        add_key 'vlp_documents', value: ->(_v) {[]}
                        add_key 'ridp_documents', value: ->(_v) {[]}
                        add_key 'verification_type_history_elements', value: ->(_v) {[]}
                        add_key 'local_residency_responses', value: ->(_v) {[]}
                        add_key 'local_residency_requests', value: ->(_v) {[]}
                      end

                      # add_key 'resident_role'
                      add_key 'individual_market_transitions', value: ->(_v) {[]}
                      add_key 'verification_types', value: ->(_v) {[]}
                      # add_key 'broker_role'
                      add_key 'emails', function: lambda {|v|
                        # revisit if condition for emails and phone for dependents
                        # if v.resolve('family.family_members.is_primary_applicant').item ==
                        #     v.find(Regexp.new("attestations.members")).map(&:item).last
                        [{ address: v.resolve('family.family_members.person.email.address').item, kind: 'home' }]
                        # end
                      }
                      add_key 'phones', function: lambda {|v|
                        # revisit if condition for emails and phone for dependents
                        # if v.resolve('family.family_members.is_primary_applicant').item ==
                        #     v.find(Regexp.new("attestations.members")).map(&:item).last
                        [{ extension: v.resolve('family.family_members.person.phone.ext').item,
                            kind: v.resolve('family.family_members.person.phone.type').item.to_s.downcase,
                            area_code: v.resolve('family.family_members.person.phone.number').item[0..2],
                            number: v.resolve('family.family_members.person.phone.number').item[3..9],
                            primary: true,
                            full_phone_number: v.resolve('family.family_members.person.phone.number').item,
                            start_on: nil,
                            end_on: nil }]
                        # end
                      }
                      add_key 'documents', value: ->(_v) {[]}
                      add_key 'age_off_excluded'
                      map 'sex', 'person_demographics.gender', function: lambda {|value|
                        value.to_s.downcase
                      }, memoize_record: true, append_identifier: true
                      map 'birthDate', 'person_demographics.dob', function: lambda {|value|
                        convert_to_date(value)
                      }, memoize_record: true, append_identifier: true
                      map 'ssn', 'person_demographics.ssn', memoize_record: true, append_identifier: true

                      # map transform not working for values with arrays
                      # revist the code for values as array
                      # work around is to memoize_record
                      # map 'ethnicity', 'person_demographics.ethnicity', memoize_record: true, visible: false
                      # map 'race', 'person_demographics.race', memoize_record: true, visible: false

                      # add_key 'person_demographics.ethnicity', value: ->(v) {v.resolve('ethnicity').item}
                      # add_key 'person_demographics.race', value: ->(v) {v.resolve('race').item}

                      add_key 'person_demographics.tribal_id'
                      add_key 'person_demographics.no_ssn', value: lambda { |v|
                                                                      v.resolve('person_demographics.ssn', identifier: true).item.nil? ? "1" : "0"
                                                                    }
                      add_key 'person_demographics.language_code'
                      add_key 'person_demographics.date_of_death', value: ->(_v) {Date.parse("2021-05-07")} # default value
                      add_key 'person_demographics.dob_check'

                      map 'noHomeAddressIndicator', 'is_homeless'
                      map 'liveOutsideStateTemporarilyIndicator', 'is_temporarily_out_of_state'

                      # add_namespace 'tax_household_members', type: :array do
                      #   rewrap 'family.household.tax_households.tax_household_members', type: :array do
                      #     add_key 'kind', value: 'home'

                      #   end
                      # end

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

                  # transform not working
                  # revist the code for values as array
                  # map 'income', 'income' , memoize_record: true
                  # # [1,2,3,4,5].each do |i|
                  # #   map "income.currentIncome.currentIncome#{i}",
                  #         "family.magi_medicaid_applications.'->(v){v.resolve(:members).item}'.income.currentIncome.currentIncome#{i}" ,
                  #           memoize_record: true, visible: false
                  # # end
                  map 'income.currentIncome', 'income.currentIncome', memoize_record: true, visible: false
                  map 'family', 'family', memoize_record: true, visible: false # , append_identifier: true
                  map 'nonMagi', 'nonMagi', memoize_record: true, visible: false
                  # map 'lawfulPresence.naturalizedCitizenIndicator', 'naturalizedCitizenIndicator', memoize: true, visible: false

                  map 'lawfulPresence.noAlienNumberIndicator', 'noAlienNumberIndicator', memoize: true, visible: false, append_identifier: true
                  map 'lawfulPresence.citizenshipIndicator', 'citizenshipIndicator', memoize: true, visible: false, append_identifier: true
                  map 'lawfulPresence.naturalizedCitizenIndicator', 'naturalizedCitizenIndicator', memoize: true, visible: false,
                                                                                                    append_identifier: true
                  map 'insuranceCoverage.employerSponsoredCoverageOffers', 'insuranceCoverage.employerSponsoredCoverageOffers',
                      memoize_record: true, visible: false
                  add_key 'person.consumer_role.lawful_presence_determination.citizen_status',
                          function: AcaEntities::Functions::BuildLawfulPresenceDetermination.new

                  add_key 'person.person_health.is_tobacco_user', value: 'unknown'
                  add_key 'person.person_health.is_physically_disabled',
                          function: lambda {|v|
                            attr = v.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last
                            attr.nil? ? nil : attr[:blindOrDisabledIndicator]
                          }
                  add_key 'person.is_disabled',
                          function: lambda {|v|
                            attr = v.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last
                            attr.nil? ? nil : attr[:blindOrDisabledIndicator]
                          }

                  map 'other.americanIndianAlaskanNative.personRecognizedTribeIndicator',
                      'person.person_demographics.personRecognizedTribeIndicator'
                  map 'other.incarcerationType', 'person.person_demographics.is_incarcerated',
                      function: lambda {|value|
                        AcaEntities::Types::McrToCvIncarcerationKind[value]
                      }
                end
              end

              # add_key 'household.start_date'
              # add_key 'household.end_date'
              # add_key 'household.is_active'
              add_key 'household.irs_group_reference', value: ->(_v) {{}}
              # add_key 'household.tax_households', function: AcaEntities::Functions::Build.new
              # add_key 'household.tax_households.tax_household_members' {}
              # add_key 'household.tax_households.eligibility_determinations', value: ->(_v) {Array.new}
              add_key 'households', function: AcaEntities::Functions::BuildHousehold.new
              # add_key 'household.hbx_enrollments', value: ->(_v) {[]}

              # transform not working to build array (type: array for add namespace)
              # revist the code
              # namespace "computed" do
              #   namespace 'taxHouseholds.*', nil, context: {name: 'taxHouseholdsmembers'} do
              #     map 'maxAPTC', "maxAPTC.'->(v){v.resolve(:taxHouseholdsmembers).item}'",
              #           memoize: true, visible: false
              #     map 'taxHouseHoldComposition',
              #         "taxHouseHoldComposition.'->(v){v.resolve(:taxHouseholdsmembers).item}'",
              #           memoize: true, visible: false

              #     # add_key 'person.consumer_role.lawful_presence_determination.citizen_status',
              #               function: AcaEntities::Functions::BuildLawfulPresenceDetermination.new

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
              #         add_key 'is_primary_family_member',
              #           function: ->(v) {v.resolve('family.family_members.is_primary_applicant').item ==
              #                             v.resolve(:members).item}
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
              #       add_key 'is_subscriber',
              #         function: ->(v) {v.resolve('family.family_members.is_primary_applicant').item ==
              #                           v.resolve(:members).item}
              #       add_key 'reason'
              #     end
              #   end
              # end
            end
          end
          namespace 'computed' do
            rewrap 'family', type: :hash do
              namespace 'members' do
                map '*', 'member', memoize_record: true
              end
              add_key 'magi_medicaid_applications', function: AcaEntities::Functions::BuildApplication.new
            end
          end

          # namespace "computed" do
          #   rewrap 'family', type: :hash do
          #     namespace 'taxHouseholds.*', nil, context: {name: 'taxHouseholdsmembers'} do
          #       rewrap 'household.tax_households' , type: :array do
          #         map 'maxAPTC', "maxAPTC.'->(v){v.resolve(:taxHouseholdsmembers).item}'", memoize: true, visible: false
          #         map 'taxHouseHoldComposition', "taxHouseHoldComposition.'->(v){v.resolve(:taxHouseholdsmembers).item}'",
          #               memoize: true, visible: false
          #       end
          #       # add_key 'person.consumer_role.lawful_presence_determination.citizen_status',
          #                   function: AcaEntities::Functions::BuildLawfulPresenceDetermination.new

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
# rubocop:enable Metrics/ClassLength
