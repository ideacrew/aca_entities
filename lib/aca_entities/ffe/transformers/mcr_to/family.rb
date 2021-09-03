# frozen_string_literal: true

require 'aca_entities/functions/email'
require 'aca_entities/functions/phone'
require 'aca_entities/functions/address'
require 'aca_entities/functions/relationship_builder'
require 'aca_entities/functions/broker_account_builder'
require 'aca_entities/functions/age_on'
require 'aca_entities/functions/primary_applicant_builder'
require 'aca_entities/functions/build_vlp_document'

require 'aca_entities/functions/build_tax_household'

require 'aca_entities/functions/build_lawful_presence_determination'
require 'aca_entities/functions/build_application'
require 'aca_entities/functions/build_household'
require 'aca_entities/functions/applicant_builder'
require 'aca_entities/functions/tax_filer_builder'
require 'aca_entities/functions/income'
require 'aca_entities/functions/benefit'
require 'aca_entities/ffe/transformers/cv/address'
require 'aca_entities/ffe/transformers/cv/phone'
require 'aca_entities/ffe/transformers/cv/vlp_document'
require 'aca_entities/ffe/transformers/cv/esc'
require 'aca_entities/ffe/transformers/cv/medicaid'
require 'aca_entities/ffe/types'

# rubocop:disable Metrics/ClassLength
# This file defines the maps
module AcaEntities
  module Ffe
    module Transformers
      module McrTo
        # Transform Keys and Values
        class Family < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          # start transform from this record_delimiter key in the given JSON record
          record_delimiter 'applications.identifier.result'

          # map 'source key from hash', 'namespaced output key/rename key',
          ### memoize: (to store this particular key in memory for later use),
          ### visible: (to display in output hash)
          map 'coverageYear', 'assistance_year', memoize: true, visible: false

          ### function: (for value transform)
          map 'insuranceApplicationIdentifier', 'family.hbx_id', function: ->(value) {value.to_s}, memoize: true

          ### memoize_record: (to store entire hash under this particular key in memory for later use)
          map 'lastUpdateMetadata', 'lastUpdateMetadata', memoize_record: true

          # namespace 'source key from hash' and block
          namespace 'attestations' do
            map 'application', 'application', memoize_record: true, visible: false
            # rewrap elements under attestations to family
            ### type: (build family as :hash or :array)
            rewrap 'family', type: :hash do
              # Only elements mentioned in rewrap is assigned to family

              # add_key 'new key/ namespaced key'
              ### value: ->(_v) {}
              ### function:  as a proc or a custom build function
              add_key 'foreign_keys', value: ->(_v) {[]}

              namespace 'application' do
                map 'spokenLanguageType', 'family_members.person.consumer_role.language_preference', memoize: true, visible: false

                namespace 'legalAttestations' do
                  map 'renewEligibilityYearQuantity', 'years_to_renew', memoize: true, visible: false
                  map 'absentParentAgreementIndicator', 'parent_living_out_of_home_terms', memoize: true, visible: false
                  map 'changeInformationAgreementIndicator', 'report_change_terms', memoize: true, visible: false
                  map 'medicaidRequirementAgreementIndicator', 'medicaid_terms', memoize: true, visible: false
                  map 'renewalAgreementIndicator', 'is_renewal_authorized', memoize: true, visible: false
                  # map 'nonIncarcerationAgreementIndicator', 'is_renewal_authorized', memoize: true, visible: false
                  # map 'penaltyOfPerjuryAgreementIndicator', 'is_renewal_authorized', memoize: true, visible: false
                  # map 'terminateCoverageOtherMecFoundAgreementIndicator', 'is_renewal_authorized', memoize: true, visible: false
                end

                # TODO: insuranceApplicationSecurityQuestionType
                # TODO: insuranceApplicationSecurityQuestionAnswer

                # TODO: applicationSignatures
                #   applicationSignatureText
                #   applicationSignatureType
                #   applicationSignatureDate

                map 'requestingFinancialAssistanceIndicator', 'is_applying_for_assistance', memoize: true, visible: false
              end

              add_key 'general_agency_accounts', value: ->(_v) {[]}
              # this need to set
              add_key 'special_enrollment_periods', value: ->(_v) {[]}
              add_key 'irs_groups', value: ->(_v) {[]}
              add_key 'broker_accounts', function: AcaEntities::Functions::BrokerAccountBuilder.new
              add_key 'documents', value: ->(_v) {[]}
              add_key 'payment_transactions', value: ->(_v) {[]}

              map 'application.contactMemberIdentifier', 'family.family_members.is_primary_applicant', memoize: true, visible: false

              map 'application.contactInformation', 'contactInformation', memoize_record: true, visible: false

              # original key is also passed to the output hash, revist code for this scenario
              # map 'application.contactMethod', 'family.family_members.person.consumer_role.contact_method', memoize: true, visible: false

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
              # map 'household.familyRelationships', 'household.family_Relationships'

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
                  map 'requestingCoverageIndicator', 'is_coverage_applicant', memoize: true, append_identifier: true
                  add_key 'is_active'
                  add_key 'is_consent_applicant'
                  add_key 'foreign_keys', value: ->(_v) {[]}
                  add_key 'hbx_id', value: ->(v) { v.find(/attestations.members.(\w+)$/).map(&:item).last }

                  namespace 'demographic' do

                    # keys ["ssn", "birthDate", "name", "sex", "maritalStatus",
                    # "noHomeAddressIndicator", "liveOutsideStateTemporarilyIndicator"
                    # "hispanicOriginIndicator", "americanIndianAlaskanNativeIndicator",  # not storing
                    # "race", "ethnicity","otherRaceText", "otherEthnicityText"
                    # "mailingAddress", "homeAddress", "transientAddress"
                    # "ssnAlternateName"]

                    rewrap 'family.family_members.person', type: :hash do
                      # add_key 'family_Relationships', function: AcaEntities::Functions::BuildRelationships.new
                      add_key 'hbx_id', function: lambda {|v|
                        v.find(/attestations.members.(\w+)$/).map(&:item).last
                      }

                      # TODO: check on identifiers

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
                            v.find(/attestations.members.(\w+)$/).map(&:item).last
                          }
                          # should pick id from the source payload
                        end
                      end

                      namespace 'name' do
                        rewrap 'family.family_members.person.person_name', type: :hash do
                          map 'firstName', 'first_name', memoize: true, append_identifier: true
                          map 'lastName', 'last_name', memoize: true, append_identifier: true
                          map 'middleName', 'middle_name', memoize: true, append_identifier: true
                          add_key 'full_name',
                                  function: lambda {|v|
                                              [v.resolve(:first_name, identifier: true).item,
                                               v.resolve(:middle_name, identifier: true).item,
                                               v.resolve(:last_name, identifier: true).item].join(' ')
                                            }
                        end
                      end

                      namespace 'ssnAlternateName' do
                        map 'firstName', 'alt_first_name', memoize: true, append_identifier: true, visible: false
                        map 'lastName', 'alt_last_name', memoize: true, append_identifier: true, visible: false
                        map 'middleName', 'alt_middle_name', memoize: true, append_identifier: true, visible: false
                      end

                      add_key 'person_name.alternate_name',
                              value: lambda {|v|
                                       [v.resolve("alt_first_name.#{v.find(/attestations.members.(\w+)$/).map(&:item).last}", identifier: true).item,
                                        v.resolve("alt_middle_name.#{v.find(/attestations.members.(\w+)$/).map(&:item).last}", identifier: true).item,
                                        v.resolve("alt_last_name.#{v.find(/attestations.members.(\w+)$/).map(&:item).last}",
                                                  identifier: true).item].join(' ')
                                     }

                      map 'noHomeAddressIndicator', 'is_homeless', memoize: true, visible: true, append_identifier: true
                      map 'liveOutsideStateTemporarilyIndicator', 'is_temporarily_out_of_state', memoize: true, visible: true, append_identifier: true
                      # map 'requestingFinancialAssistanceIndicator', 'is_applying_for_assistance'

                      # this need to set only for primary member
                      add_key 'is_applying_for_assistance', function: lambda { |v|
                                                                        v.resolve('is_applying_for_assistance').item
                                                                      }

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
                        add_key 'is_applying_coverage', function: ->v {v.resolve('is_coverage_applicant', identifier: true).item}
                        add_key 'bookmark_url'
                        add_key 'admin_bookmark_url'
                        add_key 'contact_method', function: ->(_v) { "Paper and Electronic communications" }
                        # function: ->(v) {
                        #   value = v.resolve('family.family_members.person.consumer_role.contact_method')&.item
                        #   if value == ["EMAIL", "E_TEXT"] || value == ["E_TEXT", "EMAIL"] || value == ["EMAIL"] || value ==  ["E_TEXT"]
                        #     "Only Electronic communications"
                        #   elsif value == ["EMAIL"]
                        #     "Only Electronic communications"
                        #   else
                        #     "Paper and Electronic communications"
                        #   end
                        # }

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

                      add_key 'emails', function: AcaEntities::Functions::Email.new
                      add_key 'phones', function: AcaEntities::Functions::Phone.new

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

                      map 'race', 'race', memoize: true, visible: false,  append_identifier: true
                      map 'ethnicity', 'ethnicity', memoize: true, visible: false,  append_identifier: true
                      map 'otherRaceText', 'otherRaceText', memoize: true, visible: false,  append_identifier: true
                      map 'otherEthnicityText', 'otherEthnicityText', memoize: true, visible: false,  append_identifier: true

                      add_key 'person_demographics.ethnicity',
                              value: lambda { |v|
                                       [v.resolve("race.#{v.find(/attestations.members.(\w+)$/).map(&:item).last}").item,
                                        v.resolve("ethnicity.#{v.find(/attestations.members.(\w+)$/).map(&:item).last}").item,
                                        v.resolve("otherRaceText.#{v.find(/attestations.members.(\w+)$/).map(&:item).last}").item,
                                        v.resolve(
                                          "otherEthnicityText.#{v.find(/attestations.members.(\w+)$/).map(&:item).last}"
                                        ).item].flatten.compact
                                     }

                      # race value storing in ethnicity, enroll doesn't have race record.
                      # add_key 'person_demographics.race', value: ->(v) {v.resolve('race').item}

                      # Tribal id value missing
                      add_key 'person_demographics.tribal_id'
                      add_key 'person_demographics.no_ssn', value: lambda { |v|
                                                                     v.resolve('person_demographics.ssn', identifier: true).item.nil? ? "1" : "0"
                                                                   }
                      add_key 'person_demographics.language_code'
                      add_key 'person_demographics.date_of_death', value: ->(_v) {Date.parse("2021-05-07")} # default value
                      add_key 'person_demographics.dob_check'

                      # add_namespace 'tax_household_members', type: :array do
                      #   rewrap 'family.household.tax_households.tax_household_members', type: :array do
                      #     add_key 'kind', value: 'home'

                      #   end
                      # end

                      # keys ["streetName1", "streetName2", "cityName", "stateCode", "zipCode","countyName","countryCode"
                      # "plus4Code", , "countyFipsCode"]

                      map 'mailingAddress', 'mailingAddress', memoize_record: true, visible: false
                      map 'homeAddress', 'homeAddress', memoize_record: true, visible: false
                      map 'transientAddress', 'transientAddress', memoize_record: true, visible: false

                      add_key 'addresses', function: lambda { |v|
                        m_address = v.resolve("attestations.members.*.demographic.mailingAddress", identifier: true).item&.merge!(kind: "mailing")
                        h_address = v.resolve("attestations.members.*.demographic.homeAddress", identifier: true).item&.merge!(kind: "home")
                        t_address = v.resolve("attestations.members.*.demographic.transientAddress", identifier: true).item&.merge!(kind: "transient")
                        [m_address, h_address, t_address].compact.each_with_object([]) do |address, collect|
                          collect << AcaEntities::Ffe::Transformers::Cv::Address.transform(address)
                        end
                      }
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
                  map 'income', 'income', memoize_record: true, visible: false
                  map 'family', 'family', memoize_record: true, visible: false # , append_identifier: true
                  map 'nonMagi', 'nonMagi', memoize_record: true, visible: false
                  map 'other.veteranIndicator', 'veteranIndicator', memoize: true, visible: false, append_identifier: true

                  # map 'lawfulPresence', 'lawfulPresence', memoize_record: true, visible: false,  append_identifier: true

                  map 'lawfulPresence.noAlienNumberIndicator', 'noAlienNumberIndicator', memoize: true, visible: false, append_identifier: true
                  map 'lawfulPresence.citizenshipIndicator', 'citizenshipIndicator', memoize: true, visible: false, append_identifier: true
                  map 'lawfulPresence.naturalizedCitizenIndicator', 'naturalizedCitizenIndicator', memoize: true, visible: false,
                                                                                                   append_identifier: true

                  map 'lawfulPresence.lawfulPresenceStatusIndicator', 'lawfulPresenceStatusIndicator', memoize: true, visible: false,
                                                                                                       append_identifier: true
                  map 'lawfulPresence.lawfulPresenceDocumentation', 'lawfulPresenceDocumentation', memoize_record: true, visible: false,
                                                                                                   append_identifier: true

                  map 'insuranceCoverage', 'insuranceCoverage',
                      memoize_record: true, visible: false
                  map 'medicaid', 'medicaid',
                      memoize_record: true, visible: false
                  add_key 'person.consumer_role.lawful_presence_determination.citizen_status',
                          function: AcaEntities::Functions::BuildLawfulPresenceDetermination.new

                  add_key 'person.consumer_role.vlp_documents',
                          function: AcaEntities::Functions::BuildVlpDocument.new

                  add_key 'person.person_health.is_tobacco_user', value: 'unknown'
                  add_key 'person.person_health.is_physically_disabled',
                          function: lambda {|v|
                            attr = v.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last
                            attr.nil? ? false : attr[:blindOrDisabledIndicator]
                          }
                  add_key 'person.is_disabled',
                          function: lambda {|v|
                            attr = v.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last
                            attr.nil? ? false : attr[:blindOrDisabledIndicator]
                          }

                  map 'other.americanIndianAlaskanNative.personRecognizedTribeIndicator',
                      'person.person_demographics.personRecognizedTribeIndicator'
                  map 'other.incarcerationType', 'person.person_demographics.is_incarcerated',
                      function: lambda {|value|
                        val = AcaEntities::Types::McrToCvIncarcerationKind[value]
                        val.nil? ? false : val
                      }
                end
              end

              # add_key 'household.start_date'
              # add_key 'household.end_date'
              # add_key 'household.is_active'
              add_key 'households.irs_group_reference', value: ->(_v) {{}}
              # add_key 'household.tax_households', function: AcaEntities::Functions::Build.new
              # add_key 'household.tax_households.tax_household_members' {}
              # add_key 'household.tax_households.eligibility_determinations', value: ->(_v) {Array.new}
              # add_key 'households', function: AcaEntities::Functions::BuildHousehold.new
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

              namespace 'taxHouseholds' do
                map '*', 'taxHousehold', memoize_record: true
              end

              # add_key 'households', function: AcaEntities::Functions::BuildHousehold.new

              add_key 'households',
                      function: AcaEntities::Functions::BuildHousehold.new

              # namespace 'taxHouseholds.*', nil, context: {name: 'taxHouseholdsmembers'} do
              #   rewrap 'household.tax_households' , type: :array do
              #
              #
              #
              #     map 'maxAPTC', "maxAPTC.'->(v){v.resolve(:taxHouseholdsmembers).item}'", memoize: true, visible: false
              #     map 'taxHouseHoldComposition', "taxHouseHoldComposition.
              # '->(v){v.resolve(:taxHouseholdsmembers).item}'", memoize: true, visible: false
              #
              #   end
              # end

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